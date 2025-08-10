class SetDefaultWatchedMinutesForVideos < ActiveRecord::Migration[7.1]
  def change
    # Set default value for existing null records
    Video.where(watched_minutes: nil).update_all(watched_minutes: 0)
    
    # Change column to have default value
    change_column_default :videos, :watched_minutes, 0
  end
end
