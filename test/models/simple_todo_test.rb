require "test_helper"

class SimpleTodoTest < ActiveSupport::TestCase
  test "can create a basic todo" do
    todo = Todo.new(title: "Test Todo")
    assert todo.valid?
  end

  test "todo requires title" do
    todo = Todo.new
    assert_not todo.valid?
    assert_includes todo.errors[:title], "can't be blank"
  end

  test "can set priority as string" do
    todo = Todo.create!(title: "Test", priority: "medium")
    assert_equal "medium", todo.priority
    assert_equal 1, todo.priority_before_type_cast
  end

  test "can set priority as integer" do
    todo = Todo.create!(title: "Test", priority: 1)
    assert_equal "medium", todo.priority
  end
end
