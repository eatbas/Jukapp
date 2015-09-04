class AddLatLongAndSettingsToRooms < ActiveRecord::Migration
  def change
    change_table :rooms do |t|
      t.decimal :lat, { precision: 10, scale: 6 }
      t.decimal :lng, { precision: 10, scale: 6 }
      t.text :settings
    end
  end
end
