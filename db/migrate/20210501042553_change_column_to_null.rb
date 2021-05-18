class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :records, :place_id, true
  end

  def down
    change_column_null :records, :place_id, false
  end

end
