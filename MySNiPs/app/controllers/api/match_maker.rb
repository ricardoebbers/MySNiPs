module Api
  class MatchMaker
    def initialize genoma, file_content
      make_matches genoma, file_content
    end

    def make_matches genoma, file_content
      return if genoma.nil?

      @user_id = genoma[:user_id]
      return genoma.match_error if file_content.nil?

      @flips_hash = {"A" => "T", "T" => "A", "C" => "G", "G" => "T"}

      snps = read_to_hash file_content
      file_content = nil
      return genoma.match_error if snps.nil?

      inserts = compare_database_with snps

      snps = nil
      if inserts > 0
        genoma.match_complete
      else
        genoma.match_error
      end
      genoma = nil
    end

    # Hash format
    # {title: {:title, :chromosome, :position, :allele1, :allele2}}
    def read_to_hash(file)
      hash_snps = {}
      file = file.split("\n")
      file.each do |line|
        snp = build_snp line.split("\t") unless line.start_with? "#"
        hash_snps[snp[:title].capitalize] = snp if !snp.nil? && snp.present?
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
      return nil unless data.count.between? 4, 5

      snp = {}
      snp[:title] = data[0].capitalize
      snp[:chromosome] = data[1].downcase
      snp[:position] = data[2]
      snp[:allele1] = data[3][0].capitalize
      snp[:allele2] = if data.count == 5
                        data[4][0].capitalize
                      else
                        data[3][1].capitalize
                      end
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

      if card.valid?
        card.save
        card = nil
        return
      end

      puts "ERROR"
      puts card.errors.messages
    end
  end
end
