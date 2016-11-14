require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get register:post" do
    params = {
      email: 'david',
      password: 123,
      password_confirmation: 123
    }
    post '/register', params: params
    assert_response :success
  end

  test 'create another should return 422' do
    params = {
      email: 'david',
      password: 123,
      password_confirmation: 123
    }
    post '/register', params: params
    assert_response :success

    post '/register', params: params
    assert_response :unprocessable_entity
  end

end
