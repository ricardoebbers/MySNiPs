class AdicionarColunasCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :user_id, :integer
    add_foreign_key :cards, :users, column: :user_id, primary_key: "id"

    add_column :cards, :genotype_id, :integer
    add_foreign_key :cards, :genotypes, column: :genotype_id, primary_key: "id"
  end
end
