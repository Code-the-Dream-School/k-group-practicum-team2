require 'rails_helper'

RSpec.describe "Profiles", type: :request do
    fixtures :users, :profiles

    let(:user) { users(:one) }
    let(:profile) { profiles(:one) }

    before do
        login_as(user, scope: :user)
    end

    describe "GET /users/:user_id/profiles" do
        it "excludes current_user's profile" do
            get user_profiles_path(user)

            expect(response).to have_http_status(:ok)
            expect(response.body).to include(profiles(:two).first_name)
            expect(response.body).not_to include(profile.first_name)
        end
    end

    describe "GET /users/:user_id/profiles/new" do
        it "returns success" do
            get new_user_profile_path(user)
            expect(response).to have_http_status(:ok)
        end
    end

    describe "GET /users/:user_id/profiles/:id/edit" do
        it "returns success" do
            get edit_user_profile_path(user, profile)
            expect(response).to have_http_status(:ok)
        end
    end

    describe "POST /users/:user_id/profiles" do
        context "with valid params" do
            it "creates a new profile with the correct attributes" do
                user_without_profile = users(:three)

                login_as(user_without_profile, scope: :user)

                expect {
                    post user_profiles_path(user_without_profile), params: {
                        profile: { first_name: "John", last_name: "Lee", bio: "Hello", skill_level: "junior" }
                    }
                }.to change(Profile, :count).by(1)

                profile = user_without_profile.reload.profile

                expect(profile).to be_present
                expect(profile.first_name).to eq("John")
                expect(profile.last_name).to eq("Lee")
                expect(profile.bio).to eq("Hello")
                expect(profile.skill_level).to eq("junior")
                expect(response).to redirect_to(user_dashboard_path(user_without_profile))
            end
        end

        context "with invalid params" do
            it "returns unprocessable entity" do
                user_without_profile = users(:two)
                login_as(user_without_profile, scope: :user)

                post user_profiles_path(user_without_profile), params: {
                    profile: { first_name: "", last_name: "" }
                }

                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    describe "PATCH /users/:user_id/profiles/:id" do
        context "with valid params" do
            it "updates the profile and redirects" do
                patch user_profile_path(user, profile), params: { profile: { first_name: "Sisi", last_name: profile.last_name, skill_level: profile.skill_level, bio: profile.bio } }
                profile.reload
                expect(profile.first_name).to eq("Sisi")
                expect(response).to redirect_to(user_profile_path(user, profile))
            end
        end

        context "with invalid params" do
            it "renders unprocessable entity" do
                patch user_profile_path(user, profile), params: { profile: { first_name: "" } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
