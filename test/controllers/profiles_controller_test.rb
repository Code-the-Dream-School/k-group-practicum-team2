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

  test "should create profile for user" do
    @profile.destroy

    assert_difference("Profile.count", 1) do
      post user_profiles_path(@user), params: {
        profile: {
          first_name: "New",
          last_name: "Profile",
          bio: "Created in test"
        }
      }
    end
    @user.reload
    assert_redirected_to user_profile_path(@user, @user.profile)
  end

  test "should update profile" do
    patch user_profile_path(@user, @profile), params: {
      profile: {
        first_name: "Updated",
        bio: "Updated bio"
      }
    }

    assert_redirected_to user_profile_path(@user, @profile)

    @profile.reload
    assert_equal "Updated", @profile.first_name
    assert_equal "Updated bio", @profile.bio
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

  test "show displays user's projects when user has projects" do
    @user.projects.create!(
      title: "Test Project",
      description: "Project description"
    )

    get user_profile_path(@user, @profile)
    assert_response :success

    assert_match "Test Project", response.body
  end

  test "should show 'no projects' message when user has no projects" do
    @user.projects.destroy_all

    get user_profile_path(@user, @profile)
    assert_response :success


    assert_select "p", text: "no projects"
  end
end
