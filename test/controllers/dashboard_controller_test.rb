require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h2", "Welcome back! 👋"
  end

  test "should display course statistics" do
    get root_url
    assert_response :success
    assert_select ".text-lg", text: /Total Courses/
  end

  test "should display pending todos" do
    get root_url
    assert_response :success
    assert_select "h3", "Pending Todos"
  end

  test "should show recent activity" do
    get root_url
    assert_response :success
    # Should display some recent activity
  end

  test "should have quick action buttons" do
    get root_url
    assert_response :success
    assert_select "a[href='#{new_course_path}']", "Add Course"
    assert_select "a[href='#{new_book_path}']", "Add Book"
    assert_select "a[href='#{new_article_path}']", "Add Article"
  end

  test "should get progress page" do
    get progress_url
    assert_response :success
  end
end
