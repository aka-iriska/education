require 'test_helper'

class AvoidantControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get avoidant_index_url
    assert_response :success
  end

  test 'should get people' do
    get avoidant_people_url
    assert_response :success
  end

  test 'should get create_post' do
    get create_post_url
    assert_response :success
  end

  test 'should get home' do
    get avoidant_home_url
    assert_response 302
  end

  test 'should get signin' do
    get signin_url
    assert_response :success
  end

  test 'should get signup' do
    get signup_url
    assert_response :success
  end
end
