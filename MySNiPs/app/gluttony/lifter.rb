require_relative "../models/application_record"
require_relative "../models/gene"
require_relative "../models/genotype"
class Lifter < ApplicationController
  attr_accessor :gene_id

  def initialize
    @gene_id = {}
    @count = 0
  end

  def create_gene(gene)
    Gene.new(gene.to_s)
  end

  def get_gene_id(title)
    # TO-DO
  end

  def create_genotype(geno)
    # TO-DO
  end
end
