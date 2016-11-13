require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'Category wont create without user' do
    params = {
      name: 'shopping'
    }
    user = Category.create(params)
    assert_not user.persisted?
  end
  
end
