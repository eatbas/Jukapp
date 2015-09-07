class BumpDescriptionOnYoutubeVideos < ActiveRecord::Migration
  def change
    change_column :youtube_videos, :description, :text
  end
end
