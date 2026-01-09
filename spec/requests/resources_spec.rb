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

    it 'returns a page containing title, descriptions and urls of all the resources' do
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

  describe "POST /resources" do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    before do
      sign_in user, scope: :user
    end

    it 'creates a new resource associated with the current user when title, description and url exist' do
      post '/resources', params: {
        resource: {
          title: 'New Resource',
          description: 'Resource description.',
          url: 'https://example.com'
        }
      }

      expect(response).to redirect_to(resources_path)

      expect(Resource.last.title).to eq('New Resource')
      expect(Resource.last.description).to eq('Resource description.')

      expect(Resource.last.user).to eq(user)
    end

    it 'does not create a resource when no title is provided' do
      expect {
        post '/resources', params: {
          resource: {
            title: nil,
            description: 'Resource description.',
            url: 'https://example.com'
          }
        }
      }.to_not change(Resource, :count)
    end

    it 're-renders the form when no title is provided' do
      post '/resources', params: {
        resource: {
          title: nil,
          description: 'Resource description.'
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'does not create a resource when no url is provided' do
      expect {
        post '/resources', params: {
          resource: {
            title: 'New Resource',
            description: 'Resource description.',
            url: nil
          }
        }
      }.to_not change(Resource, :count)
    end

    it 're-renders the form when no title is provided' do
      post '/resources', params: {
        resource: {
          title: 'New Resource',
          description: 'Resource description.',
          url: nil
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
