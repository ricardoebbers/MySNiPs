class CardsController < ApplicationController
  def make_report
    @useridentity = params[:identification] if params.key? :identification

    # REMOVE
    @useridentity = "0010000001"
    # REMOVE

    return if @useridentity.nil?

    user = User.find_by(identifier: @useridentity)
    return if user.nil?

    @user_id = user[:id]

    @flips_hash = {"A" => "T", "T" => "A", "C" => "G", "G" => "T"}

    file = File.open(Rails.root.join("data", "genomas", @useridentity + ".gnm"), "r")
    snps = read_to_hash file
    file.close

    compare_database_with snps
  end

  def read_to_hash(file)
    hash_snps = {}
    file.each do |line|
      snp = build_snp line.split("\t")
      hash_snps[snp[:title].capitalize] = snp
    end
    hash_snps
  end

  def compare_database_with snps
    Gene.find_each do |gene|
      match = snps[gene[:title]]
      next if match.nil?

      geno = search_for_genotype match[:allele1], match[:allele2], gene
      next if geno.nil?

      insert_in_db geno[:id]
    end
  end

  def build_snp(data)
    return nil if data.count != 4

    snp = {}
    snp[:title] = data[0].capitalize
    snp[:chromosome] = data [1]
    snp[:position] = data[2]
    snp[:allele1] = data[3][0]
    snp[:allele2] = data[3][1]
    snp
  end

  def search_for_genotype(allele1, allele2, gene)
    # False is minus orientation in SNPedia, thus there's a need to flip the alleles
    if gene[:orientation] == false
      allele1 = flip allele1
      allele2 = flip allele2
    end

    Genotype.find_by(gene_id: gene[:id], allele1: allele1, allele2: allele2)
  end

  def flip(allele)
    @flips_hash[allele] or allele
  end

  def insert_in_db(geno_id)
    card = Card.new(user_id: @user_id, genotype_id: geno_id)
    puts card.inspect

    return card.save if card.valid?

    puts "ERROR"
    puts card.errors.messages
  end
end
