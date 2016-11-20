require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @header = get_auth_header(@user)
    @category = create_category(@user)
    @purchase_name = create_purchase_name(@user)
    @purchase = create_purchase(@category, @purchase_name)
  end

  test "should get index" do
    get purchases_url, headers: @header
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post purchases_url,
        params: {
          data:{
            attributes: {
              category_id: @category.id,
              purchase_name_id: @purchase_name.id,
              price: @purchase.price 
            },
            type: 'purchase'
          }
        },
        headers: @header
    end
    assert_response 201
  end
  test "should fail purchase" do
    assert_difference('Purchase.count') do
      post purchases_url,
        params: {
          data:{
            attributes: {
              category_id: @category.id,
              purchase_name_id: @purchase_name.id,
              price: @purchase.price },
              type: 'purchase'}
            },
        headers: @header
    end
    assert_response 201
  end


  test "should show purchase" do
    get purchase_url(@purchase), headers: @header
    assert_response :success
  end

  test "should update purchase" do
    patch purchase_url(@purchase),
    params: {
      data:{
        attributes: {
          category_id: @purchase.category_id,
          purchase_name_id: @purchase_name.id,
          price: @purchase.price },
        type: 'purchase'}
      },
    headers: @header
    assert_response 200
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete purchase_url(@purchase), headers: @header
    end

    assert_response 204
  end
end
