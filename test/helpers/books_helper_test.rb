require "test_helper"

class BooksHelperTest < ActionView::TestCase
  test "currently_reading_books loads from yaml" do
    books = currently_reading_books
    assert books.is_a?(Array)
    assert books.first["title"].present?
  end
end
