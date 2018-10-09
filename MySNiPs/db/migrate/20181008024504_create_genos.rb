class CreateGenos < ActiveRecord::Migration[5.2]
  def change
    create_table :genos do |t|
      t.string :rsid, limit: 13
      t.string :revid, limit: 13
      t.string :allele1, limit: 1
      t.string :allele2, limit: 1
      t.float :magnitude
      t.integer :repute, limit: 1
      t.string :summary, limit: 130
      t.string :title, limit: 16

      t.timestamps
    end
  end
end
