class MakeGenomaStatusDefaultAs1 < ActiveRecord::Migration[5.2]
  def change
    change_column :genomas, :status, :string, :default => "1"
  end
end
