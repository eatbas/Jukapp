class AddColumnsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :played_at, :datetime
    add_column :videos, :queued_at, :datetime
    add_column :videos, :play_count, :integer
    add_column :videos, :status, :string
  end
end
