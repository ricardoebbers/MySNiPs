require "set"
require_relative "../snapi/pedia"
require_relative "./harvester"
require_relative "./storer"

module Gluttony
  class Consume
    # Controller for SNaPi
    # Run Gluttony::Consume.snpedia and it will fill the database automatically
    def snpedia
      beginning_time = Time.now.utc
      puts "Started Gluttony at: #{beginning_time}"

      pedia = SNaPi::Pedia.new
      @harvest = Gluttony::Harvester.new(pedia)
      @store = Gluttony::Storer.new(pedia)

      gather_genes(gather_genotypes) while @harvest.continue?

      end_time = Time.now.utc

      File.open("log.txt", "w+") do |f|
        f.puts "Time elapsed #{(end_time - beginning_time)} seconds"
        f.puts "Genotypes stored: #{@store.genos.size}"
        f.puts "Genes stored: #{@store.genes.size}"
      end

      File.open("genos.txt", "w+") do |f|
        f.puts(@store.genos)
      end

      File.open("genes.txt", "w+") do |f|
        f.puts(@store.genes)
      end
    end

    def gather_genotypes
      # Sets don't allow repetition and are light enough
      genetitles = Set[]
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
