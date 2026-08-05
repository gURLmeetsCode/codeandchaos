require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: /gURLmeetsCode/
  end

  test "should show post" do
    visit post_url(@post)
    assert_text @post.title
  end
end
