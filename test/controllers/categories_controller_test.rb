require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    email = 'some_email@provider.com'
    password = 'password123'
    @user = User.create({
        email: email,
        password: password,
        password_confirmation: password
      })
    assert @user.persisted?

    post '/authenticate', params: {
      email: email,
      password: password
    }
    assert_response :success
    token = JSON.parse(response.body)['auth_token']
    @header = {'Authorization': token}
  end

  test "should get index" do
    get categories_url, headers: @header
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url,
      params: { category: { name: 'a new category', user_id: @category.user_id } },
      headers: @header
    end

    assert_response 201
  end

  test "should show category" do
    get category_url(@category), headers: @header
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category),
      params: { category: { name: @category.name, user_id: @category.user_id } },
      headers: @header
    assert_response 200
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category), headers: @header
    end

    assert_response 204
  end
end
