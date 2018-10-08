require_relative "../snapi/pedia"
require_relative "./harvest"

module Gluttony
  class Consume
    # Controller for SNaPi
    def snpedia
      pedia = SNaPi::Pedia.new
      harvest = Gluttony::Harvester.new(pedia)
      store = Gluttony::Storer.new(pedia)

      # i is just so i don't download every snp when i'm testing
      i = 0
      while harvest.continue? && i < 5
        i += 1

        harvest.genos.each {|genoid| store.geno(harvest.geno_info(genoid)) }

      end
    end
  end
end
