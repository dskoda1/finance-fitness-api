require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @header = get_auth_header(@user)
  end

  test "should get me" do
    get users_me_url, headers: @header
    assert_response :success
    body = JSON.parse(response.body)
    # Check data tag
    assert body['data']
    body = body['data']
    # Check attr, id, and type
    assert body['attributes']
    assert body['id']
    assert_equal body['type'], 'users'
    body = body['attributes']
    # Check email at least
    assert body['email']


  end

end
