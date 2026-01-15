require "rails_helper"

RSpec.describe BookmarkedResource, type: :model do
    fixtures :users, :resources, :bookmarked_resources

    let(:bookmark) { bookmarked_resources(:one) }

    describe "associations" do
        it { is_expected.to belong_to(:user) }
        it { is_expected.to belong_to(:resource) }
    end

    describe "validations" do
        it "is valid with a resource" do
            expect(bookmark).to be_valid
        end

        it "is invalid without a user" do
            bookmark.user = nil
            expect(bookmark).not_to be_valid
        end

        it "is invalid without a resource" do
            bookmark.resource = nil
            expect(bookmark).not_to be_valid
        end

        it "prevents duplicate bookmarks per user/resource" do
            original = bookmarked_resources(:one)

            duplicate = BookmarkedResource.new(
                user: original.user,
                resource: original.resource
            )

            expect(duplicate).not_to be_valid
            expect(duplicate.errors[:resource_id]).to be_present
        end
    end
end
