class AddIndexesToVideos < ActiveRecord::Migration
  def change
    add_index :videos, :youtube_video_id
    add_index :videos, :room_id
  end
end
