class AddIndexToStatusInVideos < ActiveRecord::Migration
  def change
    add_index :videos, :status
  end
end
