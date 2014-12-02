class AddOwnerToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :owner, index: true, null: false, default: User.first.try(:id)
  end
end
