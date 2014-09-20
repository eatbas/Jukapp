class CreateQueuedVideos < ActiveRecord::Migration
  def change
    create_table :queued_videos do |t|
      t.references :video
      t.references :room

      t.timestamps
    end
  end
end
