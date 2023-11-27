require "test_helper"

class CalcControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get calc_input_url
    assert_response :success
  end

  test "should get view" do
    get calc_view_url
    assert_response :success
  end
  # тест со значениями 1 и 10 возвращает 11
  test "should get 11 for view with with 1+10" do
    get calc_view_url, params: { v1: 1, v2: 10, op: '+' }
    assert_equal assigns[:result], 11
  end
  # тест на получение рез unknown , если входные данные некорректны
  test "should get Unknown! for incorrect params" do
    get calc_view_url
    assert_equal assigns[:result], 'Unknown!'
  end
end
