class AddWatchedMinutesToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :watched_minutes, :integer
  end
end
