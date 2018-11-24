module Api
  class MatchMaker
    class << self

      def make_matches_for genoma, file_content
        puts "\nStarted match making\n"
        return genoma.match_error if genoma.nil?

        puts "Genoma not nil"
        @user_id = genoma[:user_id]
        return genoma.match_error if file_content.nil?

        @flips_hash = {"A" => "T", "T" => "A", "C" => "G", "G" => "T"}

        puts "SNPs not nil"
        snps = read_to_hash file_content
        file_content = nil
        return genoma.match_error if snps.nil?

        GC.start(full_mark: true, immediate_sweep: true)

        inserts = compare_database_with snps

        snps = nil
        puts "Finished match making with #{inserts} inserts"
        if inserts > 0
          genoma.match_complete
        else
          genoma.match_error
        end
        genoma = nil
        GC.start(full_mark: true, immediate_sweep: true)
      end

      # Hash format
      # {title: {:chromosome, :position, :allele1, :allele2}}
      def read_to_hash(file)
        hash_snps = {}
        file = file.split("\n")
        file.each do |line|
          #puts line
          next if line.blank? || line.start_with?("#")
          line = line.split(/\s+/)
          next if !line.size.between?(4, 5)
          hash_snps[line.shift.capitalize] = build_snp line
        end
        hash_snps
      end

      # Iterates through the Genes in the database
      # Comparing them with the snp hash
      # Then searching for the Genotype in the database
      def compare_database_with snps
        progress = 0
        inserts = 0
        genes = Gene.pluck(:id, :title, :orientation)
        genos = Genotype.all.select(:id, :title).index_by(&:title).except(:title)
        loop do
          gene = genes.shift
          break if gene.nil?

          progress += 1
          #puts progress.to_s + "/" + snps.size.to_s + "\n" + inserts.to_s + " CARDS"
          match = snps[gene[1]]
          next if match.nil?

          if gene[2] == false
            match[:allele1] = flip match[:allele1]
            match[:allele2] = flip match[:allele2]
          end

          geno_title = gene[1] + "(#{match[:allele1]};#{match[:allele2]})"
          geno = genos[geno_title]
          next if geno.nil?

          geno_id = geno.id

          insert_in_db geno_id
          inserts += 1
        end
        genes = nil
        genos = nil
        inserts
      end

      # Interprets the lines from the genome file into a simple hash
      # [:chromossome, :position, :alleles] or [:chromossome, :position, :allele1, :allele2]
      def build_snp(data)
        snp = {}
        snp[:allele1] = data[2][0].capitalize
        if data.length == 3
          snp[:allele2] = !data[2][1].nil? ? data[2][1].capitalize : data[2][0].capitalize
        else
          snp[:allele2] = data[3][0].capitalize
        end
        data = nil
        snp
      end

      def flip allele
        @flips_hash[allele] or allele
      end

      def insert_in_db(geno_id)
        card = Card.new(user_id: @user_id, genotype_id: geno_id)

        card.save if card.valid?
        card = nil
      end
    end
  end
end
