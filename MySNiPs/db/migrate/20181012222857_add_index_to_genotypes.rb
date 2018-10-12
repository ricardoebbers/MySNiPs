class AddIndexToGenotypes < ActiveRecord::Migration[5.2]
  def change
    add_index :genotypes, :title, unique: true
    add_index :genes, :title, unique: true
    add_index :genes, :rsid, unique: true
    add_index :genes, :iid, unique: true
  end
end
