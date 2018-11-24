module Api
  class MatchMaker
    def initialize
      GC.start(full_mark: true, immediate_sweep: true)
    end

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
      file = file.split("\n").map {|line| line.split("\t") }
      line = ["#"]
      until line.nil?
        while line.blank? || line[0].start_with?("#") || !line.size.between?(4, 5)
          line = file.shift
          break if line.nil?
        end

        break if line.nil?

        hash_snps[line[0].capitalize] = build_snp line.slice(3, line.size)
        line = file.shift
      end
      file = nil
      hash_snps
    end

    # Iterates through the Genes in the database
    # Comparing them with the snp hash
    # Then searching for the Genotype in the database
    def compare_database_with snps
      progress = 0
      inserts = 0
      Gene.find_each do |gene|
        progress += 1
        #puts progress.to_s + "/" + snps.size.to_s + "\n" + inserts.to_s + " CARDS"
        match = snps[gene[:title]]
        next if match.nil?

        geno = search_for_genotype match[:allele1], match[:allele2], gene
        next if geno.nil?

        insert_in_db geno[:id]
        inserts += 1
      end
      inserts
    end

    # Interprets the lines from the genome file into a simple hash
    def build_snp(data)
      snp = {}
      snp[:allele1] = data[0][0].capitalize
      snp[:allele2] = if data.count == 2
                        data[1][0].capitalize
                      else
                        data[0][1].capitalize
                      end
      data = nil
      snp
    end

    def search_for_genotype(allele1, allele2, gene)
      # False is minus orientation in SNPedia, thus there's a need to flip the alleles
      if gene[:orientation] == false
        allele1 = @flips_hash[allele1] or allele1
        allele2 = @flips_hash[allele2] or allele2
      end

      Genotype.find_by(gene_id: gene[:id], allele1: allele1, allele2: allele2)
    end

    def insert_in_db(geno_id)
      card = Card.new(user_id: @user_id, genotype_id: geno_id)

      card.save if card.valid?
      card = nil
    end
  end
end
