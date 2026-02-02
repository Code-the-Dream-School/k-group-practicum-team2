require 'rails_helper'

RSpec.describe "BookmarkedResources", type: :request do
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
      user: user2
    )
  end

  let!(:bookmarked_resource1) do
    BookmarkedResource.create!(
      user: user1,
      resource: resource2
    )
  end

  let!(:bookmarked_resource2) do
    BookmarkedResource.create!(
      user: user2,
      resource: resource1
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe 'POST /bookmarked_resources' do
    it 'creates a new resource bookmark' do
      expect {
        post "/resources/#{resource1.id}/bookmarked_resources"
      }.to change(BookmarkedResource, :count).by(1)

      expect(BookmarkedResource.last.user).to eq(user1)
      expect(BookmarkedResource.last.resource).to eq(resource1)
      expect(response).to redirect_to(resource_path(resource1))
      expect(flash[:notice]).to eq("Test Resource 1 successfully bookmarked!")
    end

    it 'does not create duplicate bookmarks' do
      expect {
        post "/resources/#{resource2.id}/bookmarked_resources"
      }.to_not change(BookmarkedResource, :count)

      expect(response).to redirect_to(resource_path(resource2))
      expect(flash[:alert]).to eq("Test Resource 2 failed to be saved as a bookmark.")
    end

    it 'does not bookmark a resource that does not exist' do
      post '/resources/nope/bookmarked_resources'

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /bookmarked_resources' do
    it 'deletes the resource bookmark and redirects with an appropriate flash message' do
      expect {
        delete "/resources/#{resource2.id}/bookmarked_resources/#{bookmarked_resource1.id}"
      }.to change(BookmarkedResource, :count).by(-1)

      expect(response).to redirect_to(resource_path(resource2))
      expect(flash[:notice]).to eq("Resource is no longer bookmarked.")
    end


    it "does not allow access to another user's bookmark" do
      expect {
        delete "/resources/#{resource1.id}/bookmarked_resources/#{bookmarked_resource2.id}"
      }.to_not change(BookmarkedResource, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end
