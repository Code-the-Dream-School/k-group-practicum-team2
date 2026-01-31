require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
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
      title: 'Test Project 1',
      description: 'Test description one.',
      status: 'mentors',
      user: user1
    )
  end

  let!(:project2) do
    Project.create!(
      title: 'Test Project 2',
      description: 'Test description two.',
      status: 'mentors',
      user: user1
    )
  end

  let!(:project3) do
    Project.create!(
      title: 'Test Project 3',
      description: 'Test description three.',
      status: 'mentors',
      user: user2
    )
  end

  let!(:bookmarked_project1) do
    BookmarkedProject.create!(
      user: user1,
      project: project1
    )
  end

  let!(:bookmarked_project2) do
    BookmarkedProject.create!(
      user: user1,
      project: project2
    )
  end

  let!(:bookmarked_project3) do
    BookmarkedProject.create!(
      user: user2,
      project: project3
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe "GET /dashboard" do
    before do
      get '/dashboard'
    end

    it 'responds with 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it "displays a user's bookmarked projects" do
      expect(response.body).to include('Test Project 1')
      expect(response.body).to include('Test Project 2')
    end

    it "does not display bookmarks belonging to another user" do
      expect(response.body).to_not include('Test Project 3')
    end
  end
end