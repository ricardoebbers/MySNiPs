class Dropcolumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :genotypes, :users_id
  end
end
