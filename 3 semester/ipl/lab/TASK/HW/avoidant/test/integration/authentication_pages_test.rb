require 'test_helper'

# https://www.softcover.io/read/28fdb94f/ruby_on_rails_tutorial_3rd_edition/sign_up

class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  def user_params(email, password)
    { 'email' => email, 'password' => password, 'password_confirmation' => password, 'admin' => false }
  end

  def add_record(email, password)
    record = User.new(user_params(email, password))
    record.save
    record
  end

  ################################## Sign up ######################################
  # Проверяем доступность страницы регистрации
  test 'test registration page access' do
    get signup_url
    assert_response :success
  end

  # Проверяем, что нельзя зарегестрировать того же пользователя
  test 'attempt to register with existing user details' do
    # Создаем пользователя
    add_record('test@test.com', '123456')

    get signup_url
    assert_response :success

    post users_url, params: { 'authenticity_token' => 'token', 'user' => { 'email' => 'test@test.com', 'password' => '123456', 'password_confirmation' => '123456' } }

    assert_response 422
  end

  # Проверяем, что пользователя можно зарегестрировать
  test 'successfully user registration' do
    get signup_url
    assert_response :success

    # Смотрим, что такой пользователь только 1
    assert_difference 'User.count', 1 do
      post users_url, params: { 'authenticity_token' => 'token', 'user' => { 'email' => 'test@test.com', 'password' => '123456', 'password_confirmation' => '123456' } }
      follow_redirect!
    end

    assert_template 'avoidant/home'
    assert_response 200
  end

  ################################## Sign in ######################################
  # Проверяем доступность страницы входа
  test 'test login page access' do
    get signin_url
    assert_response :success
  end

  test 'successfully user login' do
    add_record('test@test.com', '123456')

    assert_difference 'User.count', 0 do
      post sessions_url, params: { 'authenticity_token' => 'token', 'session' => { 'email' => 'test@test.com', 'password' => '123456' } }
      follow_redirect!
    end

    assert_template 'avoidant/home'
    assert_response 200
  end

  test 'login of a non-existent user' do
    post sessions_url, params: { 'authenticity_token' => 'token', 'session' => { 'email' => 'test@test.com', 'password' => '123456' } }

    assert_template 'sessions/new'
    assert_response 422
  end

  test 'login without password' do
    post sessions_url, params: { 'authenticity_token' => 'token', 'session' => { 'email' => 'test@test.com', 'password' => '' } }

    assert_template 'sessions/new'
    assert_response 422
  end

  ################################## Sign out ######################################
  test 'test logout success' do
    # Добавляем тестового юзера в БД
    add_record('test@test.com', '123456')

    assert_difference 'User.count', 0 do
      # login
      post sessions_url, params: { 'authenticity_token' => 'token', 'session' => { 'email' => 'test@test.com', 'password' => '123456' } }
      follow_redirect!
    end

    assert_difference 'User.count', 0 do
      # Logout
      delete signout_url
      follow_redirect!
    end

    assert_template 'sessions/new'
    assert_response 200
  end

  ################################ It is impossible to create a post without registration ##############################
  test 'Calculations are impossible without sign in' do
    # view
    post people_finds_url, params: { 'authenticity_token'=>'test', 'find'=>{ 'address'=>'Some address', 'gender'=>'м', 'height'=>'150', 'age'=>'30', 'race'=>'', 'body_type'=>'', 'voice'=>'', 'forehead'=>'', 'ears'=>'' }, 'locale'=>'en' }
    follow_redirect!

    # Если не вошли, значит редиректимся в signin
    assert_response 200
    assert_template 'sessions/new'
  end
end
