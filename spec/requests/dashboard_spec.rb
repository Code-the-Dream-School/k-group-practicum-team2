require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  # Primary user
  let!(:user1) do
    User.create!(
      email: 'user1@example.com',
      password: 'secret'
    )
  end

  let!(:profile1) do
    Profile.create!(
      user: user1,
      first_name: 'User',
      last_name: 'One',
      skill_level: 'beginner'
    )
  end

  # Secondary user
  let!(:user2) do
    User.create!(
      email: 'user2@example.com',
      password: 'secret'
    )
  end

  let!(:profile2) do
    Profile.create!(
      user: user2,
      first_name: 'User',
      last_name: 'Two',
      skill_level: 'beginner'
    )
  end

  # Third user
  let!(:user3) do
    User.create!(
      email: 'user3@example.com',
      password: 'secret'
    )
  end

  let!(:profile3) do
    Profile.create!(
      user: user3,
      first_name: 'User',
      last_name: 'Three',
      skill_level: 'beginner'
    )
  end

  # Primary user's projects
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

  # Secondary user's projects
  let!(:project3) do
    Project.create!(
      title: 'Test Project 3',
      description: 'Test description three.',
      status: 'mentors',
      user: user2
    )
  end

  let!(:project4) do
    Project.create!(
      title: 'Test Project 4',
      description: 'Test description four.',
      status: 'mentors',
      user: user2
    )
  end

  # Third user's projects
  let!(:project5) do
    Project.create!(
      title: 'Test Project 5',
      description: 'Test description five.',
      status: 'mentors',
      user: user3
    )
  end

  # Primary user's bookmarked projects
  let!(:bookmarked_project1) do
    BookmarkedProject.create!(
      user: user1,
      project: project3
    )
  end

  let!(:bookmarked_project2) do
    BookmarkedProject.create!(
      user: user1,
      project: project4
    )
  end

  # Secondary user's bookmarked projects
  let!(:bookmarked_project3) do
    BookmarkedProject.create!(
      user: user2,
      project: project5
    )
  end

  # Primary user's resources
  let!(:resource1) do
    Resource.create!(
      title: 'Test Resource 1',
      description: 'Test description one.',
      url: 'https://example.com/resource1',
      user: user1
    )
  end

  let!(:resource2) do
    Resource.create!(
      title: 'Test Resource 2',
      description: 'Test description two.',
      url: 'https://example.com/resource2',
      user: user1
    )
  end

  # Secondary user's resources
  let!(:resource3) do
    Resource.create!(
      title: 'Test Resource 3',
      description: 'Test description three.',
      url: 'https://example.com/resource3',
      user: user2
    )
  end

  let!(:resource4) do
    Resource.create!(
      title: 'Test Resource 4',
      description: 'Test description four.',
      url: 'https://example.com/resource4',
      user: user2
    )
  end

  # Third user's resources
  let!(:resource5) do
    Resource.create!(
      title: 'Test Resource 5',
      description: 'Test description five.',
      url: 'https://example.com/resource5',
      user: user3
    )
  end

  # Primary user's bookmarked resources
  let!(:bookmarked_resource1) do
    BookmarkedResource.create!(
      user: user1,
      resource: resource3
    )
  end

  let!(:bookmarked_resource2) do
    BookmarkedResource.create!(
      user: user1,
      resource: resource4
    )
  end

  # Secondary user's bookmarked resources
  let!(:bookmarked_resource3) do
    BookmarkedResource.create!(
      user: user2,
      resource: resource5
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

    it "displays a users own projects" do
      expect(response.body).to include('Test Project 1')
      expect(response.body).to include('Test Project 2')
    end

    it "displays a users own resources" do
      expect(response.body).to include('Test Resource 1')
      expect(response.body).to include('Test Resource 2')
    end

    it "displays a user's bookmarked projects" do
      expect(response.body).to include('Test Project 3')
      expect(response.body).to include('Test Project 4')
    end

    it "displays a user's bookmarked resources" do
      expect(response.body).to include('Test Resource 3')
      expect(response.body).to include('Test Resource 4')
    end

    it "does not display bookmarks belonging to another user" do
      expect(response.body).to_not include('Test Project 5')
      expect(response.body).to_not include('Test Resource 5')
    end
  end
end
