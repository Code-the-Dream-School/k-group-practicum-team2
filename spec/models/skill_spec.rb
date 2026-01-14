require 'rails_helper'

RSpec.describe Skill, type: :model do
    subject { build(:skill) }

    describe "validations" do
        it { should validate_presence_of(:name) }
        it { should validate_uniqueness_of(:name) }
    end

    describe "associations" do
        it { should have_many(:profile_skills).dependent(:destroy) }
        it { should have_many(:profiles).through(:profile_skills) }

        it { should have_many(:project_skills).dependent(:destroy) }
        it { should have_many(:projects).through(:project_skills) }
    end
end
