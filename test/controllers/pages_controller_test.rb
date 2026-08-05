require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get start page" do
    get start_url
    assert_response :success
    assert_select "h1", text: /Glad you stopped by/
    assert_select ".start-topics", minimum: 0
    assert_select ".start-card", minimum: 0
  end

  test "should get about page" do
    get about_url
    assert_response :success
  end
end
