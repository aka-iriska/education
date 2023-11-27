require "test_helper"
#rake test:integration
#rake test TEST=test/integration/authentication_pages_test.rb
class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  def add_record(name, email, password)
    record = User.new(:name => name, :email => email, :password => password)
    record.save
    record
  end

  # Подготовить интеграционный тест,
  # позволяющий проверить регистрацию нового пользователя,
  # вход под его именем и выполнение вычислений
  ################################## Sign up ######################################
  # Проверяем доступность страницы регистрации
  test "test registration page access" do
    get signup_url
    assert_response :success
  end

  # Проверяем, что нельзя зарегестрировать того же пользователя
  test 'attempt to register with existing user details' do
    # Создаем пользователя
    add_record('test', 'test@test.com', '123456')

    get signup_url
    assert_response :success

    post users_url, params: { "user" => { "name"=>'test', "email" => "test@test.com", "password" => "123456"} }

    assert_response 422
  end

  # Проверяем, что пользователя можно зарегестрировать
  test 'successfully user registration' do
    get signup_url
    assert_response :success

    # Смотрим, что такой пользователь только 1
    assert_difference 'User.count', 1 do
      post users_url, params: { "user" => { "name"=>'test', "email" => "test@test.com", "password" => "123456"} }
      follow_redirect!
    end
    assert_template 'input'
    assert_response 200
  end
  ################################## Sign in ######################################
  # Проверяем доступность страницы входа
  test "test login page access" do
    get signin_url
    assert_response :success
  end

  test 'successfully user login' do
    add_record('test', 'test@test.com', '123456')

    assert_difference 'User.count', 0 do
      post sessions_url, params: { "session" => { "name"=>'test', "email" => "test@test.com", "password" => "123456"} }
      follow_redirect!
    end

    assert_template 'input'
    assert_response 200
  end

  test 'login of a non-existent user' do
    post sessions_url, params: { "session" => {  "name"=>'test', "email" => "test@test.com", "password" => "123456" } }

    assert_template 'sessions/new'
    assert_response 422
  end

  test 'login without password' do
    post sessions_url, params: { "session" => {"name"=>'test', "email" => "test@test.com", "password" => "" } }

    assert_template 'sessions/new'
    assert_response 422
  end

  ################################## Sign out ######################################
  test "test logout success" do
    # Добавляем тестового юзера в БД
    add_record('test', 'test@test.com', '123456')

    assert_difference 'User.count', 0 do
      # login
      post sessions_url, params: { "session" => {"name"=>'test', "email" => "test@test.com", "password" => "123456" } }
      follow_redirect!
    end

    assert_difference 'User.count', 0 do
      # Logout
      delete signout_url
      follow_redirect! # перенаправлены в input, там проверочка, что не залогинились и иедм в login
      follow_redirect! # из input в login
    end

    assert_template 'sessions/new'
    assert_response 200
  end
  #Подготовить интеграционный тест для проверки невозможности выполнения вычислений без ввода логина/пароля
  test "Calculations are impossible without sign in" do
    # view
    get view_url, params: { str: '3 5 5 4 2 6 7 8 4 3' }
    # Если не вошли, значит редиректимся в signin
    assert_response 302

    # input
    get input_url
    assert_response 302
  end
end
