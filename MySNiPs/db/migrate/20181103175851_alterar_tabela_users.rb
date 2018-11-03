class AlterarTabelaUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password_digest, :password
    change_column :users, :password, :string
  end
end
