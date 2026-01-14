require 'rails_helper'

RSpec.describe ProfileSkill, type: :model do
    describe "associations" do
        it { should belong_to(:profile) }
        it { should belong_to(:skill) }
    end

    describe "validations" do
        subject { create(:profile_skill) }

        it "validates uniqueness of skill scoped to profile" do
            should validate_uniqueness_of(:skill_id).scoped_to(:profile_id)
        end
    end

    describe "join table behavior" do
        it "connects a profile and a skill" do
            profile = create(:profile)
            skill = create(:skill)

            create(:profile_skill, profile: profile, skill: skill)

            expect(profile.skills).to include(skill)
            expect(skill.profiles).to include(profile)
        end
    end
end
