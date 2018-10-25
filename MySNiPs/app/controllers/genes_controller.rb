class GenesController < ApplicationController
  include ActiveModel::Serializers::JSON

  def new
    @gene = Gene.new
  end

  def def index
    # TO-DO
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
