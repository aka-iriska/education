require "test_helper"

class TwinsApiControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get twins_api_input_url
    assert_response :success
  end

  test "should get view" do
    get twins_api_view_url
    assert_response :success
  end
end
