class RoomstatesAdduserId < ActiveRecord::Migration
  def change
  	add_column :roomstates, :user_id, :integer
  end
end
