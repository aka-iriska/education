require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(email: 'test1@gmail.com', password: '123456', password_confirmation: '123456', remember_token: 'test_token', admin: false)
    @user.save
    @test_user = { email: 'test2@gmail.com', password: '123456', password_confirmation: '123456', remember_token: 'test_token', admin: false }
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: @test_user }
    end

    assert_redirected_to home_path
  end

  test 'should show user' do
    get user_url(locale = 'en', @user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_url(locale = 'en', @user)
    assert_response :success
  end

  test 'should update user' do
    patch user_url(locale = 'en', @user), params: { user: @test_user }
    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(locale = 'en', @user)
    end

    assert_redirected_to users_url
  end
end
