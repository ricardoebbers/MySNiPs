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
end
