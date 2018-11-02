class ModifyGenesChromosomeForLimit < ActiveRecord::Migration[5.2]
  def change
    change_column :genes, :chromosome, :string, :limit => 2
  end
end
