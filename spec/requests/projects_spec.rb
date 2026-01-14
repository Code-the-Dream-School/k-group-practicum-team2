require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "GET /projects" do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    let!(:project1) do
      Project.create!(
        title: 'Test Project 1',
        description: 'Test project description 1.',
        user: user
      )
    end

    let!(:project2) do
      Project.create!(
        title: 'Test Project 2',
        description: 'Test project description 2.',
        user: user
      )
    end

    before do
      sign_in user, scope: :user
    end

    it 'responds with 200 OK' do
      get '/projects'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing title and descriptions of all the projects' do
      get '/projects'
      expect(response.body).to include('Test Project 1')
      expect(response.body).to include('Test project description 1.')
      expect(response.body).to include('Test Project 2')
      expect(response.body).to include('Test project description 2.')
    end
  end

  describe 'GET /projects/:id' do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    let!(:project) do
      Project.create!(
        title: 'Test Project',
        description: 'Test project description.',
        user: user
      )
    end

    before do
      sign_in user, scope: :user
    end

    it 'responds with 200 OK' do
      get "/projects/#{project.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the project title' do
      get "/projects/#{project.id}"

      expect(response.body).to include('Test Project')
    end

    it 'returns a page containing the project description' do
      get "/projects/#{project.id}"

      expect(response.body).to include('Test project description')
    end
  end

  describe 'GET /projects/new' do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    before do
      sign_in user, scope: :user
    end

    it 'displays title and description labels' do
      get '/projects/new'

      expect(response.body).to include('Title')
      expect(response.body).to include('Description')
    end
  end

  describe 'POST /projects' do
    let!(:user) do
      User.create!(
        email: 'user@example.com',
        password: 'secret'
      )
    end

    before do
      sign_in user, scope: :user
    end

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

      expect(Project.last.user).to eq(user)
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
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe 'GET /projects/:id/edit' do
    let!(:user1) do
      User.create!(
        email: 'user1@example.com',
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
        title: 'New Project 1',
        description: 'New project description one.',
        user: user1
      )
    end

    let!(:project2) do
      Project.create!(
        title: 'New Project 2',
        description: 'New project description two.',
        user: user2
      )
    end

    before do
      sign_in user1, scope: :user
    end

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

    it "does not allow access to another user's resource" do
      get "/projects/#{project2.id}/edit"

      expect(response).to have_http_status(:not_found)
    end
  end
end
