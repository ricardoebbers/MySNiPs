class ChangeGenes < ActiveRecord::Migration[5.2]
  def change
    change_column :genes, :title, :string, limit: 14, :null => false
    change_column :genes, :rsid, :string, limit: 11
    change_column :genes, :iid, :string, limit: 11
    change_column :genes, :summary, :text, limit: 180
    change_column :genes, :name, :string, limit: 16
    change_column :genes, :revid, :string, limit: 10
    remove_index :genes, :iid
    remove_index :genes, :rsid                            
  end
end
