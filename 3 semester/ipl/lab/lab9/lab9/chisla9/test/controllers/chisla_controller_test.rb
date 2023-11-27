require "test_helper"

class ChislaControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get chisla_input_url
    assert_response :success
  end
  test 'for right1' do
    get chisla_input_url, params: { str: '3 5 5 4 2 6 7 8 4 3' }
    assert_equal assigns[:result][0], '2 6 7 8'
  end

  test 'for right2' do
    get chisla_input_url, params: { str: '-1 2 6 -4 5 6 7 2 1 0 1' }
    assert_equal assigns[:result][0], '-4 5 6 7'
  end

  test 'for error' do
    get chisla_input_url, params:{str: ''}
    assert_equal assigns[:result], ['', 'Что-то пошло не так']
  end
end
