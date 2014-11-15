class CreateRecommendedVideos < ActiveRecord::Migration
  def change
    create_table :recommended_videos do |t|
      t.references :video, index: true
      t.references :room, index: true

      t.timestamps
    end
  end
end
