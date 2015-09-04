class CreateYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos do |t|
      t.string   "title"
      t.string   "youtube_id", null: false
      t.integer  "length"
      t.timestamps
    end
  end
end
