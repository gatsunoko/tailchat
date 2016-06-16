class AddChatlogToRoomnum < ActiveRecord::Migration
  def change
  	add_column :chatlogs, :room_num, :integer
  end
end
