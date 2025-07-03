require "test_helper"

class UserProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get advatiser" do
    get user_profile_advatiser_url
    assert_response :success
  end

  test "should get publisher" do
    get user_profile_publisher_url
    assert_response :success
  end
end
