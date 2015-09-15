class YoutubeIdString < ActiveRecord::Migration
  def change
    change_column :videos, :youtube_id, :string
    change_column :favorites, :youtube_id, :string
  end
end
