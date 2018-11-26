class MakeGenomaStatusDefaultAsPending < ActiveRecord::Migration[5.2]
  def change
    change_column :genomas, :status, :string, :default => "Pendente"

  end
end
