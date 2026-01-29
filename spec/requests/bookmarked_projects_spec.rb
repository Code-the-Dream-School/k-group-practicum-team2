require 'rails_helper'

RSpec.describe "BookmarkedProjects", type: :request do
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
