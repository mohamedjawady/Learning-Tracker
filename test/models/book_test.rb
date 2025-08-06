require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(
      title: "Test Book",
      author: "Test Author",
      description: "A test book description",
      status: "not_started"
    )
  end

  test "should be valid with valid attributes" do
    assert @book.valid?
  end

  test "should require title" do
    @book.title = nil
    assert_not @book.valid?
  end

  test "should calculate progress percentage" do
    book = Book.create!(title: "Test", total_pages: 100, current_page: 50)
    assert_equal 50.0, book.progress_percentage
  end

  test "should handle progress when total_pages is zero" do
    book = Book.create!(title: "Test", total_pages: 0, current_page: 0)
    assert_equal 0, book.progress_percentage
  end

  test "should have many chapters" do
    assert_respond_to @book, :chapters
  end

  test "should validate status inclusion" do
    @book.status = "invalid_status"
    assert_not @book.valid?
  end
end
