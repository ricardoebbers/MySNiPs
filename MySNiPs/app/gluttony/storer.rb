module Gluttony
  class Storer
    # Class that will store Genos and Genes in the Database
    # Will treat every Geno individually
    # And, in turn, add its Gene if Harvest returns it
    def initialize(pedia)
      @pedia = pedia
    end

    # Returns the title of the Gene page
    def genotype_info(geno)
      # TODO

      [geno[:title][0..(geno[:title].index("(") - 1)]]
    end
  end
end
