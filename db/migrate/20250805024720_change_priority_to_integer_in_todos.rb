class ChangePriorityToIntegerInTodos < ActiveRecord::Migration[7.1]
  def up
    # First, convert existing string values to integers
    execute <<-SQL
      UPDATE todos 
      SET priority = CASE 
        WHEN priority = 'low' THEN 0
        WHEN priority = 'medium' THEN 1  
        WHEN priority = 'high' THEN 2
        ELSE NULL
      END
    SQL
    
    # Change column type to integer
    change_column :todos, :priority, :integer
  end
  
  def down
    # Change back to string
    change_column :todos, :priority, :string
    
    # Convert integers back to strings
    execute <<-SQL
      UPDATE todos 
      SET priority = CASE 
        WHEN priority = 0 THEN 'low'
        WHEN priority = 1 THEN 'medium'
        WHEN priority = 2 THEN 'high'
        ELSE NULL
      END
    SQL
  end
end
