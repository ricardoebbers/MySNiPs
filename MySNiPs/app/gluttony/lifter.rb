require_relative "../models/application_record"
require_relative "../models/gene"
require_relative "../models/genotype"
class Lifter
  attr_accessor :gene_id

  def initialize
    @gene_id = {}
  end

  def create_gene(gene)
    g = Gene.create(gene)
  end

  def get_gene_id(title)
    # TO-DO
  end

  def create_genotype(geno)
    # TO-DO
  end
end
