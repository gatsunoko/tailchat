class CreateChatlogs < ActiveRecord::Migration
  def change
    create_table :chatlogs do |t|
      t.integer :user_id
      t.text :text

      t.timestamps null: false
    end
  end
end
