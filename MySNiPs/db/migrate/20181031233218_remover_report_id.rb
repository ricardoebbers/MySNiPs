class RemoverReportId < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :report_id
  end
end
