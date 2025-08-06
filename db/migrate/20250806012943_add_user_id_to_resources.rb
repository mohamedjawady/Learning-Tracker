class AddUserIdToResources < ActiveRecord::Migration[7.1]
  def change
    # Add user_id to courses
    add_reference :courses, :user, null: false, foreign_key: true, default: 1
    
    # Add user_id to books  
    add_reference :books, :user, null: false, foreign_key: true, default: 1
    
    # Add user_id to articles
    add_reference :articles, :user, null: false, foreign_key: true, default: 1
    
    # Add user_id to todos
    add_reference :todos, :user, null: false, foreign_key: true, default: 1
    
    # Add user_id to notes
    add_reference :notes, :user, null: false, foreign_key: true, default: 1
    
    # Add user_id to calendar_events
    add_reference :calendar_events, :user, null: false, foreign_key: true, default: 1
    
    # Remove default after migration
    change_column_default :courses, :user_id, nil
    change_column_default :books, :user_id, nil
    change_column_default :articles, :user_id, nil
    change_column_default :todos, :user_id, nil
    change_column_default :notes, :user_id, nil
    change_column_default :calendar_events, :user_id, nil
  end
end
