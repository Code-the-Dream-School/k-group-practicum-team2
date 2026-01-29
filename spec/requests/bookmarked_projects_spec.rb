require 'rails_helper'

RSpec.describe "BookmarkedProjects", type: :request do
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
      description: 'Test project description one.',
      status: 'mentors',
      user: user1
    )
  end

  let!(:project2) do
    Project.create!(
      title: 'Test Project 2',
      description: 'Test project description two.',
      status: 'mentors',
      user: user2
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe 'POST /bookmarked_projects' do
    it 'creates a new project bookmark'
    it 'does not create duplicate bookmarks'
    it 'does not bookmark a project that does not exist'
  end

  describe 'DELETE /bookmarked_projects' do
    it 'deletes the project bookmark'
    it "does not allow a user to remove another user's bookmark"
  end
end
