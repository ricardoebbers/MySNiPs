module Gluttony
  class Storer
    # Class that will store Genos and Genes in the Database
    # Will treat every Geno individually
    # And, in turn, add its Gene if Harvest returns it
    attr_reader :genos
    attr_reader :genes
    def initialize
      @genos = []
      @genes = []
    end

    def close_list(name)
      case name
      when :idswrite then @ids_writefile.close unless @ids_writefile.nil?
      when :genotypes then @genotypes_file.close unless @genotypes_file.nil?
      when :genes then @genes_file.close unless @genes_file.nil?
      end
    end

    def write_ids(ids_list)
      @ids_writefile = File.open("idlist.txt", "w") if @ids_writefile.nil?
      ids_list.each do |id|
        @ids_writefile.write(id.to_s + "\n")
      end
    end

    def read_ids(name)
      @ids_list = File.open(name + ".txt", "r").to_a if @ids_list.nil?
      line = @ids_list.at(line)
      line.chomp unless line.nil?
    end

    def push_ids(id)
      @ids_list.push id
    end

    def save_gene(gene)
      @genes_file = File.open("genes.txt", "w") if @genes_file.nil?
      @genes_file.puts gene
    end

    def save_genotype(geno)
      @genotypes_file = File.open("genos.txt", "w") if @genotypes_file.nil?
      @genotypes_file.puts geno
    end
  end
end
