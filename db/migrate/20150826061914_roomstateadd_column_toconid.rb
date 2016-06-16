class RoomstateaddColumnToconid < ActiveRecord::Migration
  def change
  	add_column :roomstates, :connection_id, :integer
  end
end
