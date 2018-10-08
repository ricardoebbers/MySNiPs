class CreateGenos < ActiveRecord::Migration[5.2]
  def change
    create_table :genos do |t|
      t.string :rsd, limit: 13
      t.string :allele1, limit: 1
      t.string :allele2, limit: 1
      t.float :magnitude
      t.integer :reputation, limit: 1
      t.string :summary, limit: 130

      t.timestamps
    end
  end
end
