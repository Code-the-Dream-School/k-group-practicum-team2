require "rails_helper"

RSpec.describe Resource, type: :model do
    subject { build(:resource) }

    describe "validations" do
        it { is_expected.to validate_presence_of(:title) }
        it { is_expected.to validate_presence_of(:url) }

        it "is invalid without a title" do
            resource = build(:resource, title: nil)
            expect(resource).not_to be_valid
            expect(resource.errors[:title]).to be_present
        end

        it "is invalid without a url" do
            resource = build(:resource, url: nil)
            expect(resource).not_to be_valid
            expect(resource.errors[:url]).to be_present
        end
    end

    describe "associations" do
        it { is_expected.to have_many(:bookmarked_resources).dependent(:destroy) }
        it { is_expected.to have_many(:favorited_by).through(:bookmarked_resources) }
    end
end
