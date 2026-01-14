require "rails_helper"

RSpec.describe BookmarkedResource, type: :model do
    subject { build(:bookmarked_resource) }

    describe "associations" do
        it { is_expected.to belong_to(:user) }
        it { is_expected.to belong_to(:resource) }
    end

    describe "validations" do
        it "is valid with a resource" do
            expect(subject).to be_valid
        end

        it "is invalid without a user" do
            subject.user = nil
            expect(subject).not_to be_valid
        end

        it "is invalid without a resource" do
            subject.resource = nil
            expect(subject).not_to be_valid
        end

        it "prevents duplicate bookmarks per user/resource" do
            bookmark = create(:bookmarked_resource)
            duplicate = build(:bookmarked_resource, user: bookmark.user, resource: bookmark.resource)

            expect(duplicate).not_to be_valid
            expect(duplicate.errors[:resource_id]).to be_present
        end
    end
end
