require "test_helper"

class LabTest < ActiveSupport::TestCase
  def setup
    @course = Course.create!(title: "Test Course")
    @lab = Lab.new(
      title: "Test Lab",
      description: "A test lab description",
      order_number: 1,
      course: @course
    )
  end

  test "should be valid with valid attributes" do
    assert @lab.valid?
  end

  test "should require title" do
    @lab.title = nil
    assert_not @lab.valid?
    assert_includes @lab.errors[:title], "can't be blank"
  end

  test "should require order_number" do
    @lab.order_number = nil
    assert_not @lab.valid?
    assert_includes @lab.errors[:order_number], "can't be blank"
  end

  test "should require unique order_number within course" do
    @lab.save!
    duplicate_lab = Lab.new(
      title: "Another Lab",
      order_number: 1,
      course: @course
    )
    assert_not duplicate_lab.valid?
    assert_includes duplicate_lab.errors[:order_number], "has already been taken"
  end

  test "should allow same order_number in different courses" do
    another_course = Course.create!(title: "Another Course")
    @lab.save!
    
    another_lab = Lab.new(
      title: "Another Lab",
      order_number: 1,
      course: another_course
    )
    assert another_lab.valid?
  end

  test "should belong to course" do
    assert_respond_to @lab, :course
    assert_equal @course, @lab.course
  end

  test "should mark completed" do
    @lab.save!
    assert_not @lab.completed?
    
    @lab.mark_completed!
    assert @lab.completed?
    assert_not_nil @lab.completed_at
  end

  test "should mark incomplete" do
    @lab.update!(completed: true, completed_at: Time.current)
    assert @lab.completed?
    
    @lab.mark_incomplete!
    assert_not @lab.completed?
    assert_nil @lab.completed_at
  end

  test "should be ordered by order_number" do
    lab1 = Lab.create!(title: "Lab 1", order_number: 2, course: @course)
    lab2 = Lab.create!(title: "Lab 2", order_number: 1, course: @course)
    
    ordered_labs = Lab.ordered
    assert_equal lab2, ordered_labs.first
    assert_equal lab1, ordered_labs.second
  end
end
