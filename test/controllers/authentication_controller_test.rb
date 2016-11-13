require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest


  test "Authentication failure with no password" do
    post '/authenticate', params: {email: 'david'}
    assert_response :unauthorized
  end

  test "Authentication success" do
    email = 'some_email@provider.com'
    password = 'password123'
    u = User.create(email: email,
                password: password,
                password_confirmation: password)
    assert u.persisted?

    post '/authenticate', params: {
      email: email,
      password: password
    }
    assert_response :success
    assert JSON.parse(response.body)['auth_token']
  end

end
