class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.date :date
      t.integer :hour
      t.integer :minute
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end
