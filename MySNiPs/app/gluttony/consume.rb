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
      while @harvest.continue? && i < 1
        i += 1
        gather_genes(gather_genotypes)
      end
    end

    def gather_genotypes
      # Sets don't allow repetition and are light enough
      genetitles = Set[]
      puts @harvest.genotypes
      @harvest.genotypes.each do |genoid|
        genoinfo = @harvest.genotype_info genoid
        genetitles.add(@store.genotype_info(genoinfo)) unless genoinfo.nil?
      end
      genetitles
    end

    def gather_genes(genetitles)
      genetitles.each do |title|
        @store.gene_info(@harvest.gene_info(title))
      end
    end
  end
end

x = Gluttony::Consume.new
x.snpedia
