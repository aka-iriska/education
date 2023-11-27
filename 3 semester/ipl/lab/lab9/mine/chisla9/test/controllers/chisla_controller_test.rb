require "test_helper"

class ChislaControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get chisla_input_url
    assert_response :success
  end

  test "should get view" do
    get chisla_view_url
    assert_response :success
  end
end
