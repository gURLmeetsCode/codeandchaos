require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "reading_time_minutes uses word count at 200 wpm" do
    post = Post.new(body: ("word " * 200).strip)
    assert_equal 1, post.reading_time_minutes

    post.body = ("word " * 201).strip
    assert_equal 2, post.reading_time_minutes

    post.body = ("word " * 400).strip
    assert_equal 2, post.reading_time_minutes
  end

  test "reading_time_minutes defaults to 1 for empty body string" do
    post = Post.new(body: "")
    assert_equal 1, post.reading_time_minutes
  end
end
