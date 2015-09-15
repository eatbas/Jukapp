class AddDescriptionToYoutubeVideos < ActiveRecord::Migration
  def change
    add_column :youtube_videos, :description, :string
  end
end
