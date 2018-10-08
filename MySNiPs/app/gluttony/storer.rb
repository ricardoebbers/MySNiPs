module Gluttony
  class Storer
    # Class that will store Genos and Genes in the Database
    # Will treat every Geno individually
    # And, in turn, add its Gene if Harvest returns it
    def initialize(pedia)
      @pedia = pedia
    end

    def genotype_info(geno)
      # return geneid
      geno[:id]
    end
  end
end
