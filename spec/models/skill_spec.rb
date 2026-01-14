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

    describe "dependent destroy behavior" do
        it "destroys associated profile_skills when deletedd" do
            skill = create(:skill)
            profile = create(:profile)
            profile_skill = create(:profile_skill, skill: skill, profile: profile)

            expect { skill.destroy }.to change { ProfileSkill.count }.by(-1)
        end

        it "destroys associated project_skills when deleted" do
            skill = create(:skill)
            project = create(:project)
            project_skill = create(:project_skill, skill: skill, project: project)

            expect { skill.destroy }.to change { ProjectSkill.count }.by(-1)
        end
    end
end
