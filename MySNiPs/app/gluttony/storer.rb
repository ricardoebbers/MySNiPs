module Gluttony
  class Storer
    # Class that will store Genos and Genes in the Database
    # Will treat every Geno individually
    # And, in turn, add its Gene if Harvest returns it
    attr_reader :genos
    attr_reader :genes
    def initialize(pedia)
      @pedia = pedia
      @genos = []
      @genes = []
    end

    # Returns the title of the Gene page
    def genotype_info(geno)
      # TODO
      @genos.push(geno)
      geno[:title][0..(geno[:title].index("(") - 1)]
    end

    def gene_info(gene)
      return false if gene.nil?

      @genes.push(gene)
    end
  end
end
