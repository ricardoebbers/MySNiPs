class ModifyGenesChromosome < ActiveRecord::Migration[5.2]
  def change
    change_column :genes, :chromosome, :text
  end
end
