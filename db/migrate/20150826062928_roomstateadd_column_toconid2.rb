class RoomstateaddColumnToconid2 < ActiveRecord::Migration
  def change
  	add_column :roomstates, :connection_id, :string
  end
end
