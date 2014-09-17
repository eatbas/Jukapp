class AddDefaultValueToPlayCount < ActiveRecord::Migration
  def change
    change_column_default :videos, :play_count, 0
  end
end
