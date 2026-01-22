require 'rails_helper'

RSpec.describe Profile, type: :model do
    describe "associations" do
        it { should belong_to(:user) }
        it { should have_many(:profile_skills).dependent(:destroy) }
        it { should have_many(:skills).through(:profile_skills) }
        it { should have_one_attached(:avatar) }
    end

    describe "validations" do
        it { should validate_presence_of(:first_name) }
        it { should validate_presence_of(:last_name) }
        it { should validate_presence_of(:skill_level) }
    end
end
