require "test_helper"

class CalcControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calc_index_url
    assert_response :success
  end

  test "should get view" do
    get calc_view_url
    assert_response :success
  end
end
