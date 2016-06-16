class RoomstateChangeColumnToconid < ActiveRecord::Migration
  def change
  	remove_column :roomstates, :connection_id, :integer
  end
end
