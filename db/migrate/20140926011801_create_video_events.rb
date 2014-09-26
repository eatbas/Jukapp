class CreateVideoEvents < ActiveRecord::Migration
  def change
    create_table :video_events do |t|
      t.references :room, index: true
      t.references :video, index: true
      t.integer :play_count, default: 0
      t.datetime :played_at

      t.timestamps
    end
  end
end
