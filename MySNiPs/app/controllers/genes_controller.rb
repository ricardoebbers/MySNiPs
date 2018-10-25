class GenesController < ApplicationController
  def new
    @gene = Gene.new
  end

  def def index
    # TO-DO
  end

  def create
    @gene = Gene.new(params[0])
    redirect_to @gene if @gene.save
  end

  def import
    # Please save me, Ebbers
    gene = Gene.new
    gene.from_json(params[:gene])
    gene.save
  end
end
