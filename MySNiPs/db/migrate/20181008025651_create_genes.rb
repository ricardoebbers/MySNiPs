class CreateGenes < ActiveRecord::Migration[5.2]
  def change
    create_table :genes do |t|
      t.integer :rsd, limit: 13
      t.string :name, limit: 17
      t.integer :chromosome, limit: 2
      t.integer :position, limit: 10
      t.boolean :orientation
      t.boolean :stabilized
      t.string :summary, limit: 130
      t.string :geno1a1, limit: 1
      t.string :geno1a2, limit: 1
      t.string :geno2a1, limit: 1
      t.string :geno2a2, limit: 1
      t.string :geno3a1, limit: 1
      t.string :geno3a2, limit: 1
      t.float :gmaf

      t.timestamps
    end
  end
end
