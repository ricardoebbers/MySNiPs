class AdicionarFKgenotype < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :genotypes, :genes
  end
end
