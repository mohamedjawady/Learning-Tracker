require "test_helper"

class CourseManagementTest < ActionDispatch::IntegrationTest
  test "complete course workflow" do
    # Visit courses index
    get courses_path
    assert_response :success

    # Create a new course
    get new_course_path
    assert_response :success

    post courses_path, params: {
      course: {
        title: "Integration Test Course",
        description: "A course created during integration testing",
        instructor: "Test Instructor",
        platform: "Test Platform",
        difficulty_level: "Beginner"
      }
    }

    course = Course.last
    assert_redirected_to course_path(course)

    # Add a chapter to the course
    get new_course_chapter_path(course)
    assert_response :success

    post course_chapters_path(course), params: {
      chapter: {
        title: "Test Chapter",
        description: "A test chapter",
        order_number: 1
      }
    }

    chapter = course.chapters.last
    assert_redirected_to chapter_path(chapter)

    # Mark chapter as complete
    patch complete_chapter_path(chapter)
    
    chapter.reload
    assert chapter.completed?

    # Add a lab to the course
    get new_course_lab_path(course)
    assert_response :success

    post course_labs_path(course), params: {
      lab: {
        title: "Test Lab",
        description: "A test lab",
        order_number: 1
      }
    }

    lab = course.labs.last
    assert_redirected_to lab_path(lab)

    # Complete the lab
    patch complete_lab_path(lab)
    
    lab.reload
    assert lab.completed?

    # Update course status
    patch update_progress_course_path(course), params: {
      course: { status: "completed" }
    }

    course.reload
    assert_equal "completed", course.status
  end

  test "course progress tracking" do
    course = courses(:rails_course)
    
    # Initially should have some progress
    get course_path(course)
    assert_response :success
    
    # Progress should be calculated based on completed items
    assert_respond_to course, :progress_percentage
  end
end
