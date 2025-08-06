require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:rails_course)
  end

  test "should get index" do
    get courses_url
    assert_response :success
    assert_select "h1", "Courses"
  end

  test "should get show" do
    get course_url(@course)
    assert_response :success
    assert_select "h1", @course.title
  end

  test "should get new" do
    get new_course_url
    assert_response :success
    assert_select "h1", "Add New Course"
  end

  test "should create course" do
    assert_difference("Course.count") do
      post courses_url, params: { 
        course: { 
          title: "New Course",
          description: "Test description",
          instructor: "Test Instructor",
          platform: "Test Platform"
        } 
      }
    end

    assert_redirected_to course_url(Course.last)
    follow_redirect!
    assert_match "successfully created", response.body
  end

  test "should not create course with invalid data" do
    assert_no_difference("Course.count") do
      post courses_url, params: { 
        course: { 
          title: "",  # Invalid: title required
          description: "Test description"
        } 
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
    assert_select "h1", "Edit Course"
  end

  test "should update course" do
    patch course_url(@course), params: { 
      course: { 
        title: "Updated Title",
        description: @course.description 
      } 
    }
    assert_redirected_to course_url(@course)
    
    @course.reload
    assert_equal "Updated Title", @course.title
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
    follow_redirect!
    assert_match "successfully deleted", response.body
  end

  test "should update progress" do
    patch update_progress_course_url(@course), params: {
      course: { status: "completed" }
    }
    
    assert_redirected_to course_url(@course)
    @course.reload
    assert_equal "completed", @course.status
  end

  test "should filter courses by status" do
    get courses_url, params: { status: "in_progress" }
    assert_response :success
    assert_select ".course-card", count: Course.where(status: "in_progress").count
  end

  test "should search courses by title" do
    get courses_url, params: { search: "Rails" }
    assert_response :success
    # Should include courses with "Rails" in title
  end
end
