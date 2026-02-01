# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  fixtures :users, :profiles

  describe "#after_sign_in_path_for" do
    context "when the user has a profile" do
      let(:user) { users(:one) }

      it "redirects to the user dashboard" do
        expect(controller.after_sign_in_path_for(user))
          .to eq(user_dashboard_path)
      end
    end

    context "when the user does not have a profile" do
      let(:user) { users(:without_profile) }

      it "redirects to the new profile page" do
        expect(controller.after_sign_in_path_for(user))
          .to eq(new_user_profile_path(user))
      end
    end
  end
end
