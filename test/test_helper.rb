ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
require 'coveralls'
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
      add_filter 'app/jobs'
      add_filter 'app/mailers'
      add_filter 'app/channels'

end
Coveralls.wear!('rails')
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_user
    email = 'some_email@provider.com'
    password = 'password'
    user = User.create({
        email: email,
        password: password,
        password_confirmation: password
      })
    assert user.persisted?
    return user
  end

  def get_auth_header(user)
    post '/authenticate', params: {
      email: user.email,
      password: 'password'
    }
    assert_response :success
    token = JSON.parse(response.body)['auth_token']
    return {'Authorization': token}
  end

  def create_category(user)
    category = Category.create!(name: 'new_category', user_id: user.id)
    assert category.persisted?
    return category
  end
  def create_purchase(category)
    purchase = Purchase.create!(title: 'new_category', category_id: category.id)
    assert purchase.persisted?
    return purchase
  end
end
