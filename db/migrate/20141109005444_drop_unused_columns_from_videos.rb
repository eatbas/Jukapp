class DropUnusedColumnsFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :play_count
    remove_column :videos, :queued_at
    remove_column :videos, :played_at
    remove_column :videos, :status
  end
end
