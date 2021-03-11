class AddColumnsToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :address, :string
    add_column :places, :web, :string
    add_column :places, :cost, :integer
    add_column :places, :wifi, :string
    add_column :places, :recommend, :integer
  end
end
