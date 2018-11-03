class ChangeGenos < ActiveRecord::Migration[5.2]
  def change
    change_column :genotypes, :title, :string, limit: 18, :null => false
    change_column :genotypes, :summary, :string, limit: 280     
    change_column :genotypes, :revid, :string, limit: 10
    add_column :genotypes, :pageid, :string, limit: 7
  end
end
