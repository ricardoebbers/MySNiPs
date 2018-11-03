class ChangeSummary < ActiveRecord::Migration[5.2]
  def change
    change_column :genes, :summary, :string, limit: 180
  end
end
