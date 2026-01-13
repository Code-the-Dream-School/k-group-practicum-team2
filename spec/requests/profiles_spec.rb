require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /users/:user_id/profiles" do
    it "excludes current_user's profile" do
      other_profile = create(:profile, first_name: "Other", last_name: "User")

      get user_profiles_path(user)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Other")
      expect(response.body).not_to include(profile.first_name)
    end
  end

  describe "GET /users/:user_id/profiles/new" do
    it "returns success" do
      get new_user_profile_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/:user_id/profiles" do
    context "with valid params" do
      it "creates a profile" do
        post user_profiles_path(user), params: {
          profile: { first_name: "John", last_name: "Kim", bio: "Hello" }
        }

        user.reload
        expect(user.profile).to be_present
        expect(response).to redirect_to(user_profile_path(user, user.profile))
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post user_profiles_path(user), params: {
          profile: { first_name: "", last_name: "" }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
