require 'rails_helper'

RSpec.describe "Resources", type: :request do
  let!(:user1) do
    User.create!(
      email: 'user@example.com',
      password: 'secret'
    )
  end

  let!(:user2) do
    User.create!(
      email: 'user2@example.com',
      password: 'secret'
    )
  end

  let!(:resource1) do
    Resource.create!(
      title: 'Test Resource 1',
      description: 'Test resource description one.',
      url: 'https://example.com/resource1',
      user: user1
    )
  end

  let!(:resource2) do
    Resource.create!(
      title: 'Test Resource 2',
      description: 'Test resource description two.',
      url: 'https://example.com/resource2',
      user: user1
    )
  end

  let!(:resource3) do
    Resource.create!(
      title: 'Test Resource 3',
      description: 'Test resource description three.',
      url: 'https://example.com/resource3',
      user: user2
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe "GET /resources" do
    it "returns with 200 OK" do
      get '/resources'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing title, descriptions and urls of all the resources' do
      get '/resources'

      expect(response.body).to include('Test Resource 1')
      expect(response.body).to include('Test resource description one.')
      expect(response.body).to include('https://example.com/resource1')
      expect(response.body).to include('Test Resource 2')
      expect(response.body).to include('Test resource description two.')
      expect(response.body).to include('https://example.com/resource2')
      expect(response.body).to include('Test Resource 3')
      expect(response.body).to include('Test resource description three.')
      expect(response.body).to include('https://example.com/resource3')
    end
  end

  describe 'GET /resources/:id' do
    it 'responds with 200 OK' do
      get "/resources/#{resource1.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the resource title, description and url' do
      get "/resources/#{resource1.id}"

      expect(response.body).to include('Test Resource 1')
      expect(response.body).to include('Test resource description one.')
      expect(response.body).to include(resource1.url)
    end

    it "displays a link to edit a user's own resource" do
      get "/resources/#{resource1.id}"

      expect(response.body).to include('Edit Resource')
    end

    it "does not display a link to edit a different user's resource" do
      get "/resources/#{resource3.id}"

      expect(response.body).to_not include('Edit Resource')
    end
  end

  describe "GET /resources/new" do
    it "responds with 200 OK" do
      get "/resources/new"
      expect(response).to have_http_status(:ok)
    end

    it 'displays title, description and external link labels' do
      get '/resources/new'

      expect(response.body).to include('Title *')
      expect(response.body).to include('Description')
      expect(response.body).to include('External Link *')
    end
  end

  describe "POST /resources" do
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
      expect(Resource.last.url).to eq('https://example.com')

      expect(Resource.last.user).to eq(user1)
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

    it 're-renders the form when no url is provided' do
      post '/resources', params: {
        resource: {
          title: 'New Resource',
          description: 'Resource description.',
          url: nil
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'does not create a resource when url is invalid' do
      expect {
        post '/resources', params: {
          resource: {
            title: 'New title',
            description: 'New description.',
            url: 'not-a-valid-url'
          }
        }
      }.to_not change(Resource, :count)
    end

    it 're-renders the form when url is invalid' do
      post '/resources', params: {
        resource: {
          title: 'New Resource',
          description: 'Resource description.',
          url: 'not-a-valid-url'
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe 'GET /resources/:id/edit' do
    it 'responds with 200 OK' do
      get "/resources/#{resource1.id}/edit"

      expect(response).to have_http_status(:ok)
    end

    it 'displays the title label' do
      get "/resources/#{resource1.id}/edit"

      expect(response.body).to include('Title *')
    end

    it 'displays the description label' do
      get "/resources/#{resource1.id}/edit"

      expect(response.body).to include('Description')
    end

    it 'displays the link label' do
      get "/resources/#{resource1.id}/edit"

      expect(response.body).to include('External Link *')
    end

    it "does not allow access to another user's resource" do
      get "/resources/#{resource3.id}/edit"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PUT /resources/:id' do
    it "updates a resource's title, description and/or url when they are valid and exist" do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: 'New title',
          description: 'New description.',
          url: 'https://example.com/newurl'
        }
      }

      expect(response).to redirect_to(resource1)
      resource1.reload
      expect(resource1.title).to eq('New title')
      expect(resource1.description).to eq('New description.')
      expect(resource1.url).to eq('https://example.com/newurl')
    end

    it 'does not update the resource when no title is provided' do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: nil,
          description: 'New description',
          url: 'https://example.com/newurl'
        }
      }

      resource1.reload
      expect(resource1.title).to eq('Test Resource 1')
      expect(resource1.description).to eq('Test resource description one.')
      expect(resource1.url).to eq('https://example.com/resource1')
    end

    it 're-renders the form when no title is present' do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: nil,
          description: 'New description',
          url: 'https://example.com/newurl'
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end


    it 'does not update the resource when no url is provided' do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: 'New Title',
          description: 'New description',
          url: nil
        }
      }

      resource1.reload
      expect(resource1.title).to eq('Test Resource 1')
      expect(resource1.description).to eq('Test resource description one.')
      expect(resource1.url).to eq('https://example.com/resource1')
    end

    it 're-render the form when url is not provided' do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: 'New title',
          description: 'New description',
          url: nil
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'does not update the resource when url is invalid format' do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: 'New Title',
          description: 'New description',
          url: 'not-a-valid-url'
        }
      }

      resource1.reload
      expect(resource1.title).to eq('Test Resource 1')
      expect(resource1.description).to eq('Test resource description one.')
      expect(resource1.url).to eq('https://example.com/resource1')
    end

    it 're-renders the form when url is invalid format' do
      put "/resources/#{resource1.id}", params: {
        resource: {
          title: 'New title',
          description: 'New description.',
          url: 'not-a-valid-url'
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "does not allow access to another user's resource" do
      put "/resources/#{resource3.id}", params: {
        resource: {
          title: 'New title',
          description: 'New description',
          url: 'https://example.com/newurl'
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /resources/:id' do
    it "deletes the resource" do
      expect {
        delete "/resources/#{resource1.id}"
      }.to change(Resource, :count).by(-1)
    end

    it 'redirects to the resources index page' do
      delete "/resources/#{resource1.id}"

      expect(response).to redirect_to(resources_path)
    end

    it "does not allow access to another user's resource" do
      delete "/resources/#{resource3.id}"

      expect(response).to have_http_status(:not_found)
    end

    it "does not allow access to another user's resource" do
      expect {
        delete "/resources/#{resource3.id}"
    }.to_not change(Resource, :count)
    end
  end
  describe "bookmark buttons on resources index" do
    it "renders the POST bookmark button when resource is not bookmarked" do
      get "/resources"

      expect(response.body).to include(resource_bookmarked_resources_path(resource1))
    end

    it "renders the DELETE unbookmark button when resource is bookmarked" do
      bookmark = BookmarkedResource.create!(
        user: user1,
        resource: resource1
      )

      get "/resources"

      expect(response.body).to include(resource_bookmarked_resource_path(resource1, bookmark))
    end
  end
end
