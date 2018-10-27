class GenotypesController < ApplicationController
  def new
    @gene = Gene.find_by(get_gene_from(params["title"]))
    @geno = @gene.genotypes.build
  end

  def index
    # TO-DO
  end

  def create
    @geno = @gene.genotypes.build(params[:genotype])
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

    hash.each do |g|
      genetitle = get_gene_from g["title"]
      @gene = Gene.find_by(title: genetitle)
      break if @gene.nil?

      @geno = @gene.genotypes.new(g)
      if @geno.valid?
        @geno.save
      else
        puts @geno.inspect
        puts @geno.errors.messages
      end
    end

    flash[:success] = "File successfully read!"
  end

  def get_gene_from(genotitle)
    index = genotitle.index("(") - 1
    genotitle[0..index]
  end
end
