class AddContentToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :content, :text
  end
end
