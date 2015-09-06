class RenameYoutubeVideoIdOnVideos < ActiveRecord::Migration
  def change
    rename_column :favorites, :youtube_video_id, :youtube_id
    rename_column :videos, :youtube_video_id, :youtube_id
  end
end
