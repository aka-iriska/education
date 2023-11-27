require "test_helper"

class ChislaApiControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get chisla_api_view_url
    assert_response :success
  end
end
