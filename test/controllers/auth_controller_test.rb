require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get authenticate" do
    get auth_authenticate_url
    assert_response :success
  end
end
