require "set"
require_relative "../snapi/pedia"
require_relative "./harvester"
require_relative "./storer"
require_relative "./lifter"


module Gluttony
  class Consume
    # Controller for SNaPi
    # Run Gluttony::Consume .snpedia and it will fill the database automatically
    attr_reader :harvest
    attr_reader :store
    def initialize
      @store = Gluttony::Storer.new
      @harvest = Gluttony::Harvester.new(SNaPi::Pedia.new)
      # Saved Genes will work as a way to avoid duplicates
      @savedgenes = {}
    end

    # Creates a file with a list of all Genotypes IDs
    def make_list
      beginning_time = Time.now.utc
      puts "Started making list at: #{beginning_time}"

      ids = []
      while @harvest.continue?
        ids = @harvest.genotypes
        @store.write_ids ids unless ids.nil?
      end
      @store.close_list :idswrite

      puts "Time elapsed: #{(Time.now.utc - beginning_time)} seconds"
    end

    def split_list(number)
      # Runs a linux command that counts lines
      lines = %x(wc -l < "idlist.txt").to_i
      ids_per_file = (lines / number.to_f).ceil
      file_number = 0
      i = 0

      f = File.open("idlists/ids#{file_number}.txt", "w")
      File.open("ids.txt", "r").each do |line|
        if i == ids_per_file
          i = 0
          file_number += 1
          f = File.open("idlists/ids#{file_number}.txt", "w")
        end

        f.write(line)
        i += 1
      end
    end

    # 1st case - *Geno not nil > *Gene not saved > Get Gene > *Gene not nil > Save Geno and Gene
    # 2nd case - *Geno not nil > *Gene not saved > Get Gene > *Gene nil > Don't save
    # 3rd case - *Geno not nil > *Gene already saved > *Gene useless > Don't save, mark as useless
    # 4th case - *Geno not nil > *Gene already saved > *Gene complete > Save geno
    # 5th case - *Geno nil > Don't save
    def read_list(file)
      beginning_time = Time.now.utc
      puts "Started reading list at: #{beginning_time}"
      iterations = 0
      saved = 0

      genoid = 0
      until genoid.nil?
        begin
          iterations += 1
          puts saved.to_s + " saved out of " + iterations.to_s if (iterations % 100).zero?
          genoid = @store.read_ids file
          geno = @harvest.genotype_info genoid
          # 5th
          next if geno.nil?

          genetitle = geno[:title][0..(geno[:title].index("(") - 1)]
          gene = nil
          if @savedgenes.key? genetitle
            if @savedgenes[genetitle]
              # 4th
              saved += 1
              @store.save_genotype geno
            else
              # 3rd
              @savedgenes[genetitle] = false
            end
          else
            gene = @harvest.gene_info genetitle
            unless gene.nil? # !2nd
              # 1st
              saved += 1
              @store.save_gene gene
              @store.save_genotype geno
              @savedgenes[genetitle] = true
            end
          end
        rescue StandardError => e
          # If there is some error
          # The id will be added to the end of the list to be tried later
          @store.push_ids genoid
          puts "Error in #{genoid}, #{e.message}"
        end
      end

      @store.close_list :genes
      @store.close_list :genotypes
      puts "Time elapsed: #{(Time.now.utc - beginning_time)} seconds"
    end

    def insert_data(genefile, genofile)
      lifter = Lifter.new
      f = File.open(genefile, "r")

      f.each do |line|
        begin
          gene = eval(line)
          lifter.create_gene gene if gene.class == {}.class
        rescue StandardError => e
          puts e
        end
      end
    end
  end
end
