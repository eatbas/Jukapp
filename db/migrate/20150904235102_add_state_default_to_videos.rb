class AddStateDefaultToVideos < ActiveRecord::Migration
  def change
    change_column :videos, :status, :string, default: 'idle'
  end
end
