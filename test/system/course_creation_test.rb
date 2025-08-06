require "application_system_test_case"

class CourseCreationTest < ApplicationSystemTestCase
  test "creating a new course" do
    visit courses_path
    click_link "Add Course"

    fill_in "Title", with: "System Test Course"
    fill_in "Description", with: "A course created via system test"
    fill_in "Instructor", with: "Test Instructor"
    fill_in "Platform", with: "Test Platform"
    select "Beginner", from: "Difficulty level"

    click_button "Create Course"

    assert_text "successfully created"
    assert_selector "h1", text: "System Test Course"
  end

  test "adding chapters to a course" do
    course = courses(:rails_course)
    visit course_path(course)

    click_link "Add Chapter"

    fill_in "Title", with: "System Test Chapter"
    fill_in "Description", with: "A chapter created via system test"
    fill_in "Chapter number", with: "99"

    click_button "Create Chapter"

    assert_text "successfully created"
    assert_selector "h1", text: "System Test Chapter"
  end

  test "completing course items" do
    course = courses(:rails_course)
    visit course_path(course)

    # Should see completion checkboxes for chapters
    assert_selector "input[type='checkbox']"

    # Test completing a chapter (if any exist)
    if page.has_selector?("input[type='checkbox']:not(:checked)", wait: 1)
      first("input[type='checkbox']:not(:checked)").check
      
      # Should show some feedback about completion
      assert(page.has_text?("completed") || page.has_text?("Completed"))
    end
  end
end
