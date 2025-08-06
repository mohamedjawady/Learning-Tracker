require "test_helper"

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = Todo.new(
      title: "Test Todo",
      description: "A test todo description",
      priority: "medium"
    )
  end

  test "should be valid with valid attributes" do
    assert @todo.valid?
  end

  test "should require title" do
    @todo.title = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:title], "can't be blank"
  end

  test "should validate priority inclusion" do
    @todo.priority = "invalid"
    assert_not @todo.valid?
  end

  test "should accept valid priorities" do
    %w[low medium high].each do |priority|
      @todo.priority = priority
      assert @todo.valid?, "#{priority} should be valid"
    end
  end

  test "should toggle completion status" do
    todo = Todo.create!(title: "Test")
    assert_not todo.completed?
    
    todo.toggle_complete!
    assert todo.completed?
    assert_not_nil todo.completed_at
    
    todo.toggle_complete!
    assert_not todo.completed?
    assert_nil todo.completed_at
  end

  test "should return correct priority color" do
    @todo.priority = "high"
    assert_equal "text-red-600", @todo.priority_color
    
    @todo.priority = "medium"
    assert_equal "text-yellow-600", @todo.priority_color
    
    @todo.priority = "low"
    assert_equal "text-green-600", @todo.priority_color
  end

  test "should scope completed todos" do
    completed_todo = Todo.create!(title: "Completed", completed: true)
    pending_todo = Todo.create!(title: "Pending", completed: false)
    
    assert_includes Todo.completed, completed_todo
    assert_not_includes Todo.completed, pending_todo
  end

  test "should scope pending todos" do
    completed_todo = Todo.create!(title: "Completed", completed: true)
    pending_todo = Todo.create!(title: "Pending", completed: false)
    
    assert_includes Todo.pending, pending_todo
    assert_not_includes Todo.pending, completed_todo
  end
end
