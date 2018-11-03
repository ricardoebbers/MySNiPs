class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :users, :roles
  end
end
