class CreateRoomstates < ActiveRecord::Migration
  def change
    create_table :roomstates do |t|
      t.integer :room_num
      t.string :username

      t.timestamps null: false
    end
  end
end
