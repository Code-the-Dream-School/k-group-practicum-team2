require 'rails_helper'

RSpec.describe "Projects", type: :request do
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

  let!(:project1) do
    Project.create!(
      title: 'Test Project 1',
      description: 'Test project description one.',
      status: 0,
      user: user1
    )
  end

  let!(:project2) do
    Project.create!(
      title: 'Test Project 2',
      description: 'Test project description two.',
      status: 0,
      user: user1
    )
  end

  let!(:project3) do
    Project.create!(
      title: 'New Project 2',
      description: 'New project description three.',
      status: 0,
      user: user2
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe "GET /projects" do
    it 'responds with 200 OK' do
      get '/projects'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing title and descriptions of all the projects' do
      get '/projects'
      expect(response.body).to include('Test Project 1')
      expect(response.body).to include('Test project description one.')
      expect(response.body).to include('Test Project 2')
      expect(response.body).to include('Test project description two.')
    end
  end

  describe 'GET /projects/:id' do
    it 'responds with 200 OK' do
      get "/projects/#{project1.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the project title' do
      get "/projects/#{project1.id}"

      expect(response.body).to include('Test Project 1')
    end

    it 'returns a page containing the project description' do
      get "/projects/#{project1.id}"

      expect(response.body).to include('Test project description one.')
    end
  end

  describe 'GET /projects/new' do
    it 'displays title and description labels' do
      get '/projects/new'

      expect(response.body).to include('Title')
      expect(response.body).to include('Description')
    end
  end

  describe 'POST /projects' do
    it 'creates a new project associated with the current user when title and description exist' do
      post '/projects', params: {
        project: {
          title: "New Project",
          description: 'Project description.'
        }
      }

      expect(response).to redirect_to(projects_path)

      expect(Project.last.title).to eq('New Project')
      expect(Project.last.description).to eq('Project description.')

      expect(Project.last.user).to eq(user1)
    end

    it 'does not create a project when no title is provided' do
      expect {
        post '/projects', params: {
          project: {
            title: nil,
            description: 'Project description.'
          }
        }
      }.to_not change(Project, :count)
    end

    it 're-renders the form when no title is provided' do
      post '/projects', params: {
        project: {
          title: nil,
          description: 'Project description.'
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /projects/:id/edit' do
    it 'responds with 200 OK' do
      get "/projects/#{project1.id}/edit"

      expect(response).to have_http_status(:ok)
    end

    it 'displays the title label' do
      get "/projects/#{project1.id}/edit"

      expect(response.body).to include('Title')
    end

    it 'displays the description label' do
      get "/projects/#{project1.id}/edit"

      expect(response.body).to include('Description')
    end

    it "does not allow access to another user's project" do
      get "/projects/#{project3.id}/edit"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PUT /projects/:id' do
    it "updates a project's title and/or description when they are valid and exist" do
      put "/projects/#{project1.id}", params: {
        project: {
          title: 'New Title',
          description: 'New description.'
        }
      }

      expect(response).to redirect_to(project1)
      project1.reload
      expect(project1.title).to eq('New Title')
      expect(project1.description).to eq('New description.')
    end

    it 'responds with 422 status when title is not provided' do
      put "/projects/#{project1.id}", params: {
        project: {
          title: nil,
          description: 'New description.'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not allow access to another user's project" do
      put "/projects/#{project3.id}", params: {
        project: {
          title: 'New Title',
          description: 'New description.'
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /projects/:id' do
    it 'deletes the project' do
      expect {
        delete "/projects/#{project1.id}"
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects index page' do
      delete "/projects/#{project1.id}"

      expect(response).to redirect_to(projects_path)
    end

    it "does not allow access to another user's project" do
      delete "/projects/#{project3.id}"

      expect(response).to have_http_status(:not_found)
    end
  end
end
