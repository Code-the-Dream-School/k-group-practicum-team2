require 'rails_helper'

RSpec.describe "Resources", type: :request do
  describe "GET /resources" do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    before do
      sign_in user, scope: :user
    end

    it "returns http success" do
      get "/resources/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /resources/new" do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    before do
      sign_in user, scope: :user
    end

    it "returns http success" do
      get "/resources/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    before do
      sign_in user, scope: :user
    end

    # it "returns http success" do
    #   get "/resources/create"
    #   expect(response).to have_http_status(:success)
    # end
  end
end
