require 'rails_helper'

RSpec.describe ProjectSkill, type: :model do
    fixtures :projects, :skills, :project_skills

    describe "associations" do
        it { should belong_to(:project) }
        it { should belong_to(:skill) }
    end

    describe "validations" do
        subject { project_skills(:one) }

        it "validates uniqueness of skill scoped to project" do
            should validate_uniqueness_of(:skill_id).scoped_to(:project_id)
        end
    end

    describe "join table behavior" do
        it "connects a project and a skill" do
            project = projects(:one)
            skill = skills(:one)

            expect(project.skills).to include(skill)
            expect(skill.projects).to include(project)
        end
    end
end
