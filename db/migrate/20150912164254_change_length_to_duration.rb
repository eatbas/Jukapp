class ChangeLengthToDuration < ActiveRecord::Migration
  def change
    add_column :youtube_videos, :duration, :integer
    remove_column :youtube_videos, :length
  end
end
