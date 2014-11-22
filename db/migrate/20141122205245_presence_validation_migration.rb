class PresenceValidationMigration < ActiveRecord::Migration
  def change
    change_column_null(:favorites, :user_id, false)
    change_column_null(:favorites, :video_id, false)
    change_column_null(:recommended_videos, :room_id, false)
    change_column_null(:recommended_videos, :video_id, false)
    change_column_null(:rooms, :name, false)
    change_column_null(:videos, :youtube_id, false)
  end
end
