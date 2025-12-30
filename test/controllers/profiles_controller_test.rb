require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @profile = @user.create_profile!(first_name: "Test", last_name: "User", bio: "Testing")

    post user_session_path, params: { user: { email: @user.email, password: "password" } }
  end

  test "should get index" do
    get user_profiles_path(@user)
    assert_response :success
  end

  test "should get new" do
    get new_user_profile_path(@user)
    assert_response :success
  end

  test "should get show" do
    get user_profile_path(@user, @profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_profile_path(@user, @profile)
    assert_response :success
  end
end
