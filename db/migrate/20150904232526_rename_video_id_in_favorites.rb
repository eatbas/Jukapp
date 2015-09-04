class RenameVideoIdInFavorites < ActiveRecord::Migration
  def change
    rename_column :favorites, :video_id, :youtube_video_id
  end
end
