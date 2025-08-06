require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:pending_todo)
  end

  test "should get index" do
    get todos_url
    assert_response :success
    assert_select "h1", "Todos"
  end

  test "should get show" do
    get todo_url(@todo)
    assert_response :success
    assert_select "h1", @todo.title
  end

  test "should get new" do
    get new_todo_url
    assert_response :success
    assert_select "h1", "Add New Todo"
  end

  test "should create todo" do
    assert_difference("Todo.count") do
      post todos_url, params: { 
        todo: { 
          title: "New Todo",
          description: "Test description",
          priority: "medium"
        } 
      }
    end

    assert_redirected_to todo_url(Todo.last)
    follow_redirect!
    assert_match "successfully created", response.body
  end

  test "should not create todo without title" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { 
        todo: { 
          title: "",
          description: "Test description"
        } 
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_todo_url(@todo)
    assert_response :success
    assert_select "h1", "Edit Todo"
  end

  test "should update todo" do
    patch todo_url(@todo), params: { 
      todo: { 
        title: "Updated Todo",
        description: @todo.description 
      } 
    }
    assert_redirected_to todo_url(@todo)
    
    @todo.reload
    assert_equal "Updated Todo", @todo.title
  end

  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end

    assert_redirected_to todos_url
  end

  test "should toggle completion" do
    assert_not @todo.completed?
    
    patch toggle_complete_todo_url(@todo)
    
    @todo.reload
    assert @todo.completed?
    assert_not_nil @todo.completed_at
  end

  test "should toggle completion back to incomplete" do
    completed_todo = todos(:completed_todo)
    assert completed_todo.completed?
    
    patch toggle_complete_todo_url(completed_todo)
    
    completed_todo.reload
    assert_not completed_todo.completed?
    assert_nil completed_todo.completed_at
  end
end
