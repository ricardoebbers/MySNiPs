class ImportController < ApplicationController
  require_relative "genes_controller"
  require_relative "genotypes_controller"
  def from_file

    path_genes = Rails.root.join("data", "genes.json")
    path_genos = Rails.root.join("data", "genos.json")

    hash_genes = JSON.parse(File.read(path_genes))
    hash_genos = JSON.parse(File.read(path_genos))

    control_genes = GenesController.new
    control_genos = GenotypesController.new

    hash_genos.each do |go|
      gene_title = control_genos.get_gene_from go["title"]
      gene = Gene.find_by(title: gene_title)

      # If the gene isn't in the database yet, it will be added
      if gene.nil?
        ge = hash_genes.find {|g| g["age"] > 35 }
        gene = Gene.new(ge)

        unless gene.valid?
          puts gene.inspect
          puts gene.errors.messages
        else
          # Genotype
        end
      else

      end


    end
  end
end
