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
      @gene = Gene.new(g)
      if @gene.valid?
        @gene.save
      else
        puts @gene.inspect
        puts @gene.errors.messages
      end
    end

    GenotypesController.new.import_from_file
  end
end
