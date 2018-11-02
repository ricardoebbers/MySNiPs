class ImportController < ApplicationController
  # GET import?from=folder
  def from_file
    from = "snpedia"
    from = params[:from] if params.key? :from

    path_genes = Rails.root.join("data", from, "genes.json")
    path_genos = Rails.root.join("data", from, "genos.json")

    @hash_genes = JSON.parse(File.read(path_genes))
    @hash_genos = JSON.parse(File.read(path_genos))

    @logfile = File.open(Rails.root.join("data", "logfile.txt"), "w")

    do_import

    @logfile.close
  end

  private

  # Flow of import
  # 1. Get a Genotype
  # 2. Search its Gene using its title
  # 3.a. If the Gene is in the database, load it
  # 3.b. If the Gene isn't in the database, get from the file
  # 3.c. If the Gene isn't found anywhere, go for the next Genotype
  # 4. Checks if the Genotype is valid
  # 5.a. If its invalid and the Gene is in the database, discard the Genotype
  # 5.b. If its invalid and the Gene was loaded from file, discard both
  # 5.c. If its valid and the Gene is in the database, save the Genotype
  # 5.d. If its valid and the Gene was loaded from file, save both
  def do_import
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

        gene_saved = !gene.nil?
        gene = read_gene(gene_title) unless gene_saved

        if gene.nil?
          @logfile.puts go.inspect
          @logfile.puts "Parent gene was not found, Genotype was not saved"
        elsif save_genotype(go, gene)
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
  end

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
