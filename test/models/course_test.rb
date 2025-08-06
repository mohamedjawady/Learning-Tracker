require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = Course.new(
      title: "Test Course",
      description: "A test course description",
      instructor: "Test Instructor",
      platform: "Test Platform",
      status: "not_started"
    )
  end

  test "should be valid with valid attributes" do
    assert @course.valid?
  end

  test "should require title" do
    @course.title = nil
    assert_not @course.valid?
    assert_includes @course.errors[:title], "can't be blank"
  end

  test "should have default status of not_started" do
    course = Course.create!(title: "Test")
    assert_equal "not_started", course.status
  end

  test "should calculate progress percentage correctly" do
    course = courses(:rails_course)
    # Assuming course has some chapters in fixtures
    assert_respond_to course, :progress_percentage
  end

  test "should update status based on progress" do
    course = Course.create!(title: "Test Course")
    course.update_status_based_on_progress
    assert_equal "not_started", course.status
  end

  test "should have many chapters" do
    assert_respond_to @course, :chapters
  end

  test "should have many videos" do
    assert_respond_to @course, :videos
  end

  test "should have many labs" do
    assert_respond_to @course, :labs
  end
end
