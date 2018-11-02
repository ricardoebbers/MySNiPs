class AddUniqueToBothIdsInCards < ActiveRecord::Migration[5.2]
  def change
    add_index :cards, [:user_id, :genotype_id], unique: true
  end
end
