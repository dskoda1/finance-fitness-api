require 'test_helper'

class PurchaseNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @header = get_auth_header(@user)
    @purchase_name = create_purchase_name(@user)
  end

  test "should get index" do
    get purchase_names_url, headers: @header
    assert_response :success
  end

  test "should create purchase_name" do
    assert_difference('PurchaseName.count') do
      post purchase_names_url,
        params: {
          data: {
            attributes: {
              text: "laundry",
              user_id: @user.id
            },
            type: 'purchase_name'
          },
        },
        headers: @header
    end

    assert_response 201
  end

  test "should fail create on same name" do
    assert_no_difference('PurchaseName.count') do
      post purchase_names_url,
        params: {
          data: {
            attributes: {
              text: @purchase_name.text,
              user_id: @user.id
            },
            type: 'purchase_name'
          },
        },
        headers: @header
    end

    assert_response :unprocessable_entity
  end

  test "should show purchase_name" do
    get purchase_name_url(@purchase_name), headers: @header
    assert_response :success
  end

  test "should update purchase_name" do
    patch purchase_name_url(@purchase_name),
      params: {
        data: {
          attributes: {
            text: @purchase_name.text,
            user_id: @user.id
          },
          type: 'purchase_name'
        },
      },
      headers: @header
    assert_response 200
  end

  test "should fail update purchase_name" do
    post purchase_names_url,
      params: {
        data: {
          attributes: {
            text: 'purchase_name',
            user_id: @user.id
          },
          type: 'purchase_name'
        },
      },
      headers: @header
    assert_response 201

    patch purchase_name_url(@purchase_name),
      params: {
        data: {
          attributes: {
            text: 'purchase_name',
            user_id: @user.id
          },
          type: 'purchase_name'
        },
      },
      headers: @header
    assert_response :unprocessable_entity
  end

  test "should destroy purchase_name" do
    assert_difference('PurchaseName.count', -1) do
      delete purchase_name_url(@purchase_name), headers: @header
    end

    assert_response 204
  end
end
