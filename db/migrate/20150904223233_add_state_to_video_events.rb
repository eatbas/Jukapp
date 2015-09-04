class AddStateToVideoEvents < ActiveRecord::Migration
  def change
    change_table :video_events do |t|
      t.string :status
      t.datetime :queued_at
      t.integer :queued_by
      t.datetime :prioritized_at
      t.integer :prioritized_by
    end
  end
end
