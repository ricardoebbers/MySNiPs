class CardsController < ApplicationController
  def make_report
    @userid = params[:userid] if params.key? :userid

    # REMOVE
    @userid = "0010000001"
    # REMOVE

    return if @userid.nil?

    @cards_list = []
    read_file Rails.root.join("data", "genomas", @userid + ".gnm")
  end

  def read_file(path)
    # REMOVE
    #i = 0
    # REMOVE
    File.open(path, "r").each do |line|
      snp = build_snp line.split("\t")
      next if snp.nil?

      gene = search_for_gene snp[:title], snp[:chromosome], snp[:position]
      next if gene.nil?

      geno = search_for_genotype snp[:allele1], snp[:allele2], gene
      next if geno.nil?

      @cards_list << geno[:id]

      # REMOVE
      #i += 1
      #break if i == 20
      # REMOVE
    end

    insert_in_db
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

  def search_for_gene(title, chromo, posit)
    gene = Gene.find_by(title: title)
    return gene unless gene.nil?

    Gene.find_by(chromosome: chromo, position: posit)
  end

  def search_for_genotype(allele1, allele2, gene)
    # False is minus in SNPedia, thus there's a need to flip
    if gene[:orientation] == false
      allele1 = flip allele1
      allele2 = flip allele2
    end

    Genotype.find_by(gene_id: gene[:id], allele1: allele1, allele2: allele2)
  end

  def flip(allele)
    case allele
    when "A" then "T"
    when "T" then "A"
    when "C" then "G"
    when "G" then "C"
    end
  end

  def insert_in_db
    log = File.open(Rails.root.join("data", "genomas", @userid + " - log.txt"), "w")
    @cards_list.each do |card|
      log.puts card
    end
    log.close
  end
end
