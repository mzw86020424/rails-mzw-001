require "test_helper"

class Api::V1::LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_v1_login_login_url
    assert_response :success
  end
end
