class AddColumnPassToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pass, :string
  end
end
