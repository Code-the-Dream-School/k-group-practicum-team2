require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "GET /projects" do
    let!(:user) do
      User.create!(
        email: 'test@mail.com',
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

  describe 'GET /projects/:id', type: :request do
    let!(:user) do
      User.create!(
        email: 'test@mail.com',
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
end
