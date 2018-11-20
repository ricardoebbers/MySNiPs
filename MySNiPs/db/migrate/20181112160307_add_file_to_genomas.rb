class AddFileToGenomas < ActiveRecord::Migration[5.2]
  def change
    add_column :genomas, :file, :string
  end
end
