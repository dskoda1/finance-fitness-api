require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @header = get_auth_header(@user)
    @category = create_category(@user)
  end

  test "should fail if passed bad header" do
    get categories_url
    assert_response :unauthorized
  end

  test "should get index" do
    get categories_url, headers: @header
    assert_response :success
  end

  test "should only get current user's categories" do
    get categories_url, headers: @header
    assert_response :success
    other_user = User.create(
      email: 'OtherUser',
      password: 'pw',
      password_confirmation: 'pw')
    assert other_user.persisted?

    cats = JSON.parse(response.body)
    cats.each { |cat|
      assert_equal cat['user']['id'], @user.id
      #assert_not_equal cat['user']['id'], @other_user.id
    }

  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url,
      params: {
        category: {
          name: 'a new category',
          user_id: @category.user_id
          }
        },
      headers: @header
    end
    assert_response 201
  end
  test "should create second category same name fail" do
    assert_difference('Category.count') do
      post categories_url,
      params: {
        category: {
          name: 'a new category',
          user_id: @category.user_id
          }
        },
      headers: @header
    end
    assert_response 201
    # Second one
    post categories_url,
    params: {
      category: {
        name: 'a new category',
        user_id: @category.user_id
        }
      },
    headers: @header
    assert_response 422
  end

  test "should show category" do
    get category_url(@category), headers: @header
    assert_response :success
  end

  test "should not show other users category" do
    # create another user and try and find one of their categories
    params = {
      email: 'david_username',
      password: 123,
      password_confirmation: 123
    }
    post '/register', params: params
    assert_response :success
    u = User.where(email: params[:email]).first
    c = Category.create(name: 'another category', user_id: u.id)
    assert c.persisted?

    get category_url(c.id), headers: @header
    assert_response :unauthorized
  end

  test "should update category" do
    patch category_url(@category),
      params: {
        category: {
          name: @category.name,
          user_id: @user.id
          }
        },
      headers: @header
    assert_response 200
  end
  test "update should fail category" do
    post categories_url,
    params: {
      category: {
        name: 'a new category',
        user_id: @user.id
        }
      },
    headers: @header
    patch category_url(@category),
      params: {
        category: {
          name: 'a new category',
          user_id: @user.id
          }
        },
      headers: @header
    assert_response :unprocessable_entity
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category), headers: @header
    end

    assert_response 204
  end
end
