class AddIndexToRooms < ActiveRecord::Migration
  def change
    add_index :rooms, :name, unique: true
  end
end
