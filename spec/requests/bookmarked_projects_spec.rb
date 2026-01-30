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

  let!(:bookmarked_project1) do
    BookmarkedProject.create!(
      user: user1,
      project: project2
    )
  end

  let!(:bookmarked_project2) do
    BookmarkedProject.create!(
      user: user2,
      project: project1
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe 'POST /bookmarked_projects' do
    it 'creates a new project bookmark' do
      expect {
        post "/projects/#{project1.id}/bookmarked_projects"
      }.to change(BookmarkedProject, :count).by(1)

      expect(BookmarkedProject.last.user).to eq(user1)
      expect(BookmarkedProject.last.project).to eq(project1)
    end

    it 'does not create duplicate bookmarks' do
      expect {
        post "/projects/#{project2.id}/bookmarked_projects"
      }.to_not change(BookmarkedProject, :count)

    end

    it 'does not bookmark a project that does not exist' do
      post '/projects/nope/bookmarked_projects'

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /bookmarked_projects' do
    it 'deletes the project bookmark' do
      expect {
        delete "/projects/#{project2.id}/bookmarked_projects/#{bookmarked_project1.id}"
      }.to change(BookmarkedProject, :count).by(-1)
    end

    it "does not allow access to another user's bookmark" do
      expect {
        delete "/projects/#{project1.id}/bookmarked_projects/#{bookmarked_project2.id}"
      }.to_not change(BookmarkedProject, :count)
    end
  end
end
