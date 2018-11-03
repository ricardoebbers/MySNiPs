class AdicionarFkParaGenomas < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :genomas, :users
  end
end
