class AddLengthToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :length, :integer
  end
end
