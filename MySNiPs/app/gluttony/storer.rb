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

    # TODO
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
