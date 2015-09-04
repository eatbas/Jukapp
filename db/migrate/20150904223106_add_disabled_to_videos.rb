class AddDisabledToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.boolean :disabled, default: :false
    end
  end
end
