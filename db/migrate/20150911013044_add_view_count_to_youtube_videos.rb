class AddViewCountToYoutubeVideos < ActiveRecord::Migration
  def change
    add_column :youtube_videos, :view_count, :string
  end
end
