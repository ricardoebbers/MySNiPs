class ImportController < ApplicationController
  require_relative "genes_controller"
  require_relative "genotypes_controller"

  # GET import?from=folder
  def from_file
    from = "snpedia"
    from = params[:from] if params.key? :from

    path_genes = Rails.root.join("data", from, "genes.json")
    path_genos = Rails.root.join("data", from, "genos.json")

    @hash_genes = JSON.parse(File.read(path_genes))
    @hash_genos = JSON.parse(File.read(path_genos))

    @logfile = File.open(Rails.root.join("data", "logfile.txt"), "w")

    last_gene_title = nil
    gene = nil
    gene_saved = false
    @hash_genos.each do |go|
      gene_title = get_genetitle_from go["title"]

      if last_gene_title == gene_title && !gene.nil?
        gene.save unless gene_saved
        save_genotype(go, gene)
      else
        gene = Gene.find_by(title: gene_title)

        if gene.nil?
          gene_saved = false
          gene = read_gene(gene_title)
        end

        genotype_saved = save_genotype(go, gene) unless gene.nil?
        if genotype_saved
          gene.save
          gene_saved = true
        else
          gene_saved = false
          @logfile.puts gene.inspect
          @logfile.puts "Gene not saved because Genotype was invalid!"
        end
      end
      last_gene_title = gene_title
    end
    @logfile.close
  end

  private

  def save_genotype(geno_hash, gene)
    geno = gene.genotypes.new(geno_hash)
    if geno.valid?
      geno.save
    else
      @logfile.puts "\n"
      @logfile.puts geno.inspect
      @logfile.puts geno.errors.messages
    end
  end

  def get_genetitle_from(genotitle)
    index = genotitle.index("(") - 1
    genotitle[0..index]
  end

  def read_gene(title)
    ge = @hash_genes.find {|g| g["title"] == title }
    gene = Gene.new(ge)

    return gene if gene.valid?

    # else
    @logfile.puts "\n"
    @logfile.puts gene.inspect
    @logfile.puts gene.errors.messages
  end
end
