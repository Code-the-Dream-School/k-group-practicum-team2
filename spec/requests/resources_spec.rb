require 'rails_helper'

RSpec.describe "Resources", type: :request do
  describe "GET /resources" do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    let!(:resource1) do
      Resource.create!(
        title: 'Test Resource 1',
        description: 'Test resource description 1.',
        url: 'https://example.com/resource1',
        user: user
      )
    end

    let!(:resource2) do
      Resource.create!(
        title: 'Test Resource 2',
        description: 'Test resource description 2.',
        url: 'https://example.com/resource2',
        user: user
      )
    end

    before do
      sign_in user, scope: :user
    end

    it "returns with 200 OK" do
      get '/resources'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing title, descriptions and urls of all the projects' do
      get '/resources'

      expect(response.body).to include('Test Resource 1')
      expect(response.body).to include('Test resource description 1.')
      expect(response.body).to include('https://example.com/resource1')
      expect(response.body).to include('Test Resource 2')
      expect(response.body).to include('Test resource description 2.')
      expect(response.body).to include('https://example.com/resource2')
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

    it "responds with 200 OK" do
      get "/resources/new"
      expect(response).to have_http_status(:ok)
    end

    it 'displays title, description and external link labels' do
      get '/resources/new'

      expect(response.body).to include('Title')
      expect(response.body).to include('Description')
      expect(response.body).to include ('External link')
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
