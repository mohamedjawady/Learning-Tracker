require "test_helper"

class TodoWorkflowTest < ActionDispatch::IntegrationTest
  test "complete todo lifecycle" do
    # Visit todos index
    get todos_path
    assert_response :success

    # Should see pending and completed sections
    assert_select "h3", "Pending"
    assert_select "h3", "Completed"

    # Create a new todo
    get new_todo_path
    assert_response :success

    post todos_path, params: {
      todo: {
        title: "Integration Test Todo",
        description: "A todo created during testing",
        priority: "high",
        due_date: 1.week.from_now.to_date
      }
    }

    todo = Todo.last
    assert_redirected_to todo_path(todo)

    # Todo should be pending
    assert_not todo.completed?

    # Mark todo as complete
    patch toggle_complete_todo_path(todo)
    
    todo.reload
    assert todo.completed?
    assert_not_nil todo.completed_at

    # Visit todos index again
    get todos_path
    assert_response :success

    # Todo should now be in completed section
    # (Implementation depends on how completed todos are displayed)

    # Mark as incomplete again
    patch toggle_complete_todo_path(todo)
    
    todo.reload
    assert_not todo.completed?
    assert_nil todo.completed_at
  end

  test "todo filtering and priority" do
    get todos_path
    assert_response :success

    # Should display priority indicators
    assert_match(/HIGH|MEDIUM|LOW/, response.body)
  end
end
