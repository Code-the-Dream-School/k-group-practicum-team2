require "rails_helper"

RSpec.describe Resource, type: :model do
    fixtures :users, :resources, :bookmarked_resources

    let(:resource) { resources(:one) }

    describe "validations" do
        it "is valid with valid attributes" do
            expect(resource).to be_valid
        end

        it "is invalid without a title" do
            resource.title = nil
            expect(resource).not_to be_valid
            expect(resource.errors[:title]).to be_present
        end

        it "is invalid without a url" do
            resource.url = nil
            expect(resource).not_to be_valid
            expect(resource.errors[:url]).to be_present
        end
    end

    describe "associations" do
        it "has many bookmarked_resources dependent on destroy" do
            expect(resource.bookmarked_resources).to be_present
            expect(resource.bookmarked_resources.first.resource).to eq(resource)
        end

        it "has many favorited_by through bookmarked_resources" do
            expect(resource.favorited_by).to include(users(:one))
        end
    end
end
