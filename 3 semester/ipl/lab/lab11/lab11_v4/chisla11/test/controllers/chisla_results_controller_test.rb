require "test_helper"

class ChislaResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chisla_result = chisla_results(:one)
  end

  test "should get index" do
    get chisla_results_url
    assert_response :success
  end

  test "should get new" do
    get new_chisla_result_url
    assert_response :success
  end

  test "should create chisla_result" do
    assert_difference("ChislaResult.count") do
      post chisla_results_url, params: { chisla_result: { my_table: @chisla_result.my_table, result: @chisla_result.result, string: @chisla_result.string } }
    end

    assert_redirected_to chisla_result_url(ChislaResult.last)
  end

  test "should show chisla_result" do
    get chisla_result_url(@chisla_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_chisla_result_url(@chisla_result)
    assert_response :success
  end

  test "should update chisla_result" do
    patch chisla_result_url(@chisla_result), params: { chisla_result: { my_table: @chisla_result.my_table, result: @chisla_result.result, string: @chisla_result.string } }
    assert_redirected_to chisla_result_url(@chisla_result)
  end

  test "should destroy chisla_result" do
    assert_difference("ChislaResult.count", -1) do
      delete chisla_result_url(@chisla_result)
    end

    assert_redirected_to chisla_results_url
  end
end
