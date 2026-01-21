require 'rails_helper'

RSpec.describe ProfileSkill, type: :model do
    fixtures :users, :profiles, :skills, :profile_skills

    describe "associations" do
        it { should belong_to(:profile) }
        it { should belong_to(:skill) }
    end

    describe "validations" do
        subject { profile_skills(:one) }

        it "validates uniqueness of skill scoped to profile" do
            should validate_uniqueness_of(:skill_id).scoped_to(:profile_id)
        end
    end

    describe "join table behavior" do
        it "connects a profile and a skill" do
            profile = profiles(:one)
            skill = skills(:one)

            expect(profile.skills).to include(skill)
            expect(skill.profiles).to include(profile)
        end
    end
end
