class AddUniqueToFavorites < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :video_id], unique: true
  end
end
