require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'create single user' do
    params = {
      email:                  'xxx@yahooo.com',
      name:                   'Bill',
      password:               'soccer123',
      password_confirmation:  'soccer123'
    }
    user = User.create!(params)
    assert user.persisted?
  end
  test 'create two users will fail' do
    params = {
      email:                  'xxx@yahooo.com',
      name:                   'Bill',
      password:               'soccer123',
      password_confirmation:  'soccer123'
    }
    user = User.create(params)
    assert user.persisted?

    user = User.create(params)
    assert_not user.persisted?
  end
  test 'creates default categories on creation' do
    params = {
      email:                  'xxx@yahooo.com',
      name:                   'Bill',
      password:               'soccer123',
      password_confirmation:  'soccer123'
    }
    user = User.create!(params)
    assert user.persisted?


    categories = Category.where(user_id: user.id)
    assert categories.length > 0
  end

end
