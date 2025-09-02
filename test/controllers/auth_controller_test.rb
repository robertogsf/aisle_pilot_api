require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    post api_v1_register_path, params: { email: "test@example.com", password: "password" }
  end

  test "should get login" do
    post api_v1_login_path, params: { email: "test@example.com", password: "password" }
    assert_response :success
  end

  test "should get register" do
    post api_v1_register_path, params: { email: "test2@example.com", password: "password" }
    assert_response :success
  end
end
