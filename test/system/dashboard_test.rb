require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  test "visiting the dashboard" do
    visit root_path

    assert_selector "h2", text: "Welcome back! 👋"
    assert_selector "h3", text: "Total Courses"
    assert_selector "h3", text: "Pending Todos"
  end

  test "quick actions work" do
    visit root_path

    # Test Add Course button
    click_link "Add Course"
    assert_current_path new_course_path
    assert_selector "h1", text: "Add New Course"

    visit root_path

    # Test Add Book button
    click_link "Add Book"
    assert_current_path new_book_path

    visit root_path

    # Test Add Article button
    click_link "Add Article"
    assert_current_path new_article_path
  end

  test "navigation works from dashboard" do
    visit root_path

    # Test main navigation
    click_link "Courses"
    assert_current_path courses_path

    click_link "Books"
    assert_current_path books_path

    click_link "Articles"
    assert_current_path articles_path

    click_link "Todos"
    assert_current_path todos_path

    # Should be able to return to dashboard
    click_link "Dashboard"
    assert_current_path root_path
  end
end
