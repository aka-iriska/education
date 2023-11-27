require "test_helper"

class TwinsControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get twins_input_url
    assert_response :success
  end

  test "should get view" do
    get twins_view_url
    assert_response :success
  end
end
