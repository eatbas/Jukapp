class AddStateToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.references :youtube_video
      t.references :room
      t.string :status
      t.datetime :queued_at
      t.integer :queued_by
      t.datetime :played_at
      t.integer :play_count, default: 0
      t.datetime :prioritized_at
      t.integer :prioritized_by

      t.remove :title
      t.remove :youtube_id
      t.remove :length
      t.remove :disabled
    end
  end
end
