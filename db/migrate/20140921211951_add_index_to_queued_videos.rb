class AddIndexToQueuedVideos < ActiveRecord::Migration
  def change
    add_index(:queued_videos, :room_id)
  end
end
