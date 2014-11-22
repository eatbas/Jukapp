class ChangeDefaultForRoomOwner < ActiveRecord::Migration
  def change
    change_column_default(:rooms, :owner_id, nil)
  end
end
