class CreateGenomas < ActiveRecord::Migration[5.2]
  def change
    create_table :genomas do |t|

      t.timestamps
    end
  end
end
