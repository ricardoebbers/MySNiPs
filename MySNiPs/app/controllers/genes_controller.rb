class GenesController < ApplicationController
  include ActiveModel::Serializers::JSON

  def new
    @gene = Gene.new
  end

  def index
    # TO-DO
  end

  def create
    @gene = Gene.new(params[:gene])
    if @gene.save
      flash[:success] = "Object successfully created"
      redirect_to @gene
    else
      flash[:error] = "Something went wrong"
      render "new"
    end
  end

  def import_from_file
    path = Rails.root.join("data", "genes.json")
    file = File.read(path)
    hash = JSON.parse(file)
    hash.each do |g|
      Gene.create(g)
    end
  end
end
