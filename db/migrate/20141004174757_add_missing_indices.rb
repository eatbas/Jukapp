class AddMissingIndices < ActiveRecord::Migration
  def change
    add_index :queued_videos, :video_id
    add_index :queued_videos, [:room_id, :video_id]
  end
end
