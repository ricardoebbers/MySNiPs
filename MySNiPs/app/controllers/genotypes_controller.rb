class GenotypesController < ApplicationController
  def new
    @gene = Gene.find_by(get_gene_from(params["title"]))
    @geno = @gene.genotypes.build
  end

  def index
    # TO-DO
  end

  def create
    @geno = Genotype.new(params[:genotype])
    if @geno.save
      flash[:success] = "Object successfully created"
      redirect_to @geno
    else
      flash[:error] = "Something went wrong"
      render "new"
    end
  end

  def import_from_file
    path = Rails.root.join("data", "genos.json")
    file = File.read(path)
    hash = JSON.parse(file)
    i = 0
    hash.each do |g|
      genetitle = get_gene_from g["title"]
      gene = Gene.find_by(title: genetitle)
      gene.genotypes << Genotype.new(g)
      if gene.save
        puts "AAAAA\n"*10
      end
      i += 1
      if i > 10
        break
      end
    end
  end

  def get_gene_from(genotitle)
    index = genotitle.index("(") - 1
    genotitle[0..index]
  end
end
