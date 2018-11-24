module MatchMaker
  def self.make_matches_for(genoma, file_content)
    puts "\nStarted match making\n"
    return genoma.match_error if genoma.nil?

    puts "Genoma not nil"
    user_id = genoma[:user_id]
    return genoma.match_error if file_content.nil?

    puts "SNPs not nil"
    read_to_hash file_content
    file_content = nil
    return genoma.match_error if @hash_snps.nil?

    inserts = compare_database_with user_id

    @hash_snps = nil
    puts "Finished match making with #{inserts} inserts"
    if inserts > 0
      genoma.match_complete
    else
      genoma.match_error
    end
  end

  # Hash format
  # {title: {:chromosome, :position, :allele1, :allele2}}
  def self.read_to_hash(filee)
    @hash_snps = {}
    file = filee.split("\n")
    filee = nil
    file.each do |line|
      #puts line
      next if line.blank? || line.start_with?("#")

      arr = line.split(/\s+/)
      line = nil
      next if !arr.size.between?(4, 5)

      @hash_snps[arr.shift.capitalize] = build_snp arr
    end
  end

  # Iterates through the Genes in the database
  # Comparing them with the snp hash
  # Then searching for the Genotype in the database
  def self.compare_database_with user_id
    inserts = 0
    @genes = Gene.pluck(:id, :title, :orientation)
    @genos = Genotype.select(:id, :title)
    @genos = JSON.parse(@genos.index_by(&:title).to_json)
    loop do
      gene = @genes.shift
      break if gene.nil?

      match = @hash_snps[gene[1]]
      next if match.nil?

      if gene[2] == false
        match["allele1"] = flip(match["allele1"])
        match["allele2"] = flip(match["allele2"])
      end

      geno_title = gene[1] + "(#{match["allele1"]};#{match["allele2"]})"
      geno = @genos[geno_title]
      next if geno.nil?

      geno_id = geno["id"]

      insert_in_db(geno_id, user_id)
      inserts += 1
    end
    @genes = nil
    @genos = nil
    inserts
  end

  # Interprets the lines from the genome file into a simple hash
  # [:chromossome, :position, :alleles] or [:chromossome, :position, :allele1, :allele2]
  def self.build_snp(data)
    snp = {}
    snp["allele1"] = data[2][0].capitalize
    snp["allele2"] = if data.length == 3
                      !data[2][1].nil? ? data[2][1].capitalize : data[2][0].capitalize
                    else
                      snp["allele2"] = data[3][0].capitalize
                    end
    snp
  end

  def self.flip allele
    {"A" => "T", "T" => "A", "C" => "G", "G" => "T"}[allele] or allele
  end

  def self.insert_in_db(geno_id, user_id)
    card = Card.new(user_id: user_id, genotype_id: geno_id)

    card.save if card.valid?
  end
end
