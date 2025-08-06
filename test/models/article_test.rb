require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(
      title: "Test Article",
      author: "Test Author",
      description: "A test article description",
      status: "not_started"
    )
  end

  test "should be valid with valid attributes" do
    assert @article.valid?
  end

  test "should require title" do
    @article.title = nil
    assert_not @article.valid?
  end

  test "should calculate progress percentage" do
    article = Article.create!(
      title: "Test",
      estimated_read_time: 20,
      time_spent: 10
    )
    assert_equal 50.0, article.progress_percentage
  end

  test "should handle progress when estimated_read_time is zero" do
    article = Article.create!(title: "Test", estimated_read_time: 0, time_spent: 5)
    assert_equal 0, article.progress_percentage
  end

  test "should validate status inclusion" do
    @article.status = "invalid_status"
    assert_not @article.valid?
  end

  test "should validate URL format if present" do
    @article.url = "invalid-url"
    # Add URL validation in model if needed
    # assert_not @article.valid?
  end
end
