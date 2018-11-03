class CreateGenomas < ActiveRecord::Migration[5.2]
  def change
    create_table :genomas do |t|
      t.string :status
      t.string :log_error
      t.integer :user_id
      t.timestamps
    end
  end
end
