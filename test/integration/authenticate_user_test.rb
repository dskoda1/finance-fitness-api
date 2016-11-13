require 'test_helper'

class AuthenticateUserTest < ActiveSupport::TestCase
  setup do
    email = 'some_email@provider.com'
    password = 'password123'
    @User = User.create(email: email,
                password: password,
                password_confirmation: password)
    assert @User.persisted?
    @email = email
    @password = password
  end

  test 'Authenticates with valid credentials' do
    command = AuthenticateUser.call(@email, @password)
    assert command.success?
    assert_equal command.send('email'), @email, 'Emails should match'
    assert_equal command.send('password'), @password, 'Passwords should match'
    assert command.result
  end

  test 'Fails with bad credentials' do
    command = AuthenticateUser.call(@email, 'some other password')
    assert_not command.success?
    assert_equal command.errors[:user_authentication], ["invalid credentials"]
  end

end
