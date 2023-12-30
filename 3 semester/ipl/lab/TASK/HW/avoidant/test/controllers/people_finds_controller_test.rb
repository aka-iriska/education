require 'test_helper'

class PeopleFindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @find = PeopleFind.new(searcher_email: 'email@test1.com', searcher_name: 'Пупкин В. В.',
                     address: 'Адрес 1', age: 18, body_type: 'эктоморф', ears: 'круглые', facial_hair: 'есть',
                     gender: 'м', hair_color: '#000000', height: 180, race: 'европиоид', voice: 'тенор',
                     wrinkles: 'есть')
    @find.save
    @test_find = { searcher_email: 'email@test2.com', searcher_name: 'Пупкин В. В.',
                   address: 'Адрес 2', age: 20, body_type: 'эктоморф', ears: 'круглые', facial_hair: 'есть',
                   gender: 'м', hair_color: '#000000', height: 200, race: 'европиоид', voice: 'тенор',
                   wrinkles: 'есть' }
  end

  def user_params(email, password)
    { 'email' => email, 'password' => password, 'password_confirmation' => password, 'admin' => false }
  end

  def add_record(email, password)
    record = User.new(user_params(email, password))
    record.save
    record
  end

  test 'should get index' do
    get people_finds_url
    assert_response :success
  end

  test 'should get new' do
    get new_people_find_url
    assert_response :success
  end

  test 'should create find' do
    # Сначала регистрируемся
    add_record('test@test.com', '123456')

    assert_difference 'User.count', 0 do
      post sessions_url, params: { 'authenticity_token' => 'token', 'session' => { 'email' => 'test@test.com', 'password' => '123456' } }
      follow_redirect!
    end

    assert_template 'avoidant/home'
    assert_response 200

    assert_difference('PeopleFind.count') do
      post people_finds_url, params: { find: @test_find }
    end

    assert_redirected_to create_post_url
  end

  test 'should show find' do
    get people_find_url(locale='en', @find)
    assert_response :success
  end

  test 'should get edit' do
    get edit_people_find_url(locale='en', @find)
    assert_response :success
  end

  test 'should update find' do
    patch people_find_url(locale='en', @find), params: { find: @test_find }
    assert_redirected_to home_url
  end

  test 'should destroy find' do
    assert_difference('PeopleFind.count', -1) do
      delete people_find_url(locale='en', @find)
    end

    assert_redirected_to home_url
  end
end
