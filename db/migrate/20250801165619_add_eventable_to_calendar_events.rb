class AddEventableToCalendarEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :calendar_events, :eventable_type, :string
    add_column :calendar_events, :eventable_id, :integer
  end
end
