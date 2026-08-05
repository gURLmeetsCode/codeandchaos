require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should filter index by topic" do
    get posts_url(topic: "Rails")
    assert_response :success
    assert_select ".home-posts__title", text: /Rails/
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end
end
