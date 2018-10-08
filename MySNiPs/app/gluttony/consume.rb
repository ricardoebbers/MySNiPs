require "set"
require_relative "../snapi/pedia"
require_relative "./harvester"
require_relative "./storer"

module Gluttony
  class Consume
    # Controller for SNaPi
    def snpedia
      pedia = SNaPi::Pedia.new
      @harvest = Gluttony::Harvester.new(pedia)
      @store = Gluttony::Storer.new(pedia)

      # i is just so i don't download every snp when i'm testing
      i = 0
      while @harvest.continue? && i < 10
        i += 1
        gather_genes(gather_genos)
      end
    end

    def gather_genos
      # Sets don't allow repetition and are light enough
      geneids = Set[]
      @harvest.genos.each do |genoid|
        genoinfo = @harvest.geno_info genoid
        geneids.add(@store.geno_info(genoinfo)) unless genoinfo.nil?
      end
      geneids
    end

    def gather_genes(geneids)
      geneids.each do |geneid|
        @store.geno_info(@harvest.gene_info(geneid))
      end
    end
  end
end

x = Gluttony::Consume.new
x.snpedia
