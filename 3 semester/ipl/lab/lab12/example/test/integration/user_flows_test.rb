require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "authentication" do
    get '/signin'
    assert_response :success

    # uses name, email, password from fixures/users.yml
    post "/sessions", session: {
        username: users(:one).name,
        password: users(:one).email,
        password: users(:one).password
      }

    get '/users'
    assert_equal '/users', path

    get_via_redirect '/signout'
    assert_equal '/signin', path
  end

  test "non authenticated" do
    get_via_redirect '/users'
    assert_equal '/signin', path
  end
end
