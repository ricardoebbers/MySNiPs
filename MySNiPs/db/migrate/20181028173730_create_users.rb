class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :identifier, :null => false, index: { unique: true}
      t.string :password_digest
      t.string :report_id

      t.timestamps
    end
  end
end
