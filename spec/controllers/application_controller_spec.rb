# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "#after_sign_in_path_for" do
    let(:user) { FactoryBot.create(:user) }

    context "when the user has a profile" do
      before do
        FactoryBot.create(:profile, user: user)
      end

      it "redirects to the user dashboard" do
        expect(controller.after_sign_in_path_for(user))
          .to eq(user_dashboard_path(user))
      end
    end

    context "when the user does not have a profile" do
      it "redirects to the new profile page" do
        expect(controller.after_sign_in_path_for(user))
          .to eq(new_user_profile_path(user))
      end
    end
  end
end
