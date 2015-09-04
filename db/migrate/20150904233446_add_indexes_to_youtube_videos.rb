class AddIndexesToYoutubeVideos < ActiveRecord::Migration
  def change
    add_index :youtube_videos, :youtube_id
  end
end
