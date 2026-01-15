require "rails_helper"

RSpec.describe Project, type: :model do
  describe "associations" do
    it "belongs to a user" do
      user = User.create!(email: "user@email.com", password: "password")
      project = Project.create!(title: "Test Project", user: user)

      expect(project.user).to eq(user)
    end

    it "can have many skills through project_skills" do
      user = User.create!(email: "user@email.com", password: "password")
      project = Project.create!(title: "Test Project", user: user)

      skill1 = Skill.create!(name: "Rails")
      skill2 = Skill.create!(name: "React")

      project.skills << skill1
      project.skills << skill2

      expect(project.skills).to include(skill1, skill2)
    end

    it "tracks users who bookmarked the project" do
      owner = User.create!(email: "owner@email.com", password: "password")
      favoriter = User.create!(email: "fan@email.com", password: "password")

      project = Project.create!(title: "Test Project", user: owner)
      BookmarkedProject.create!(user: favoriter, project: project)

      expect(project.favorited_by).to include(favoriter)
    end

    it "destroys associated project_skills when deleted" do
      user = User.create!(email: "user@email.com", password: "password")
      project = Project.create!(title: "Test Project", user: user)
      skill = Skill.create!(name: "Ruby")

      project.skills << skill

      expect { project.destroy }.to change { ProjectSkill.count }.by(-1)
    end
  end

  describe "validations" do
    it "is invalid without a title" do
      user = User.create!(email: "user@email.com", password: "password")
      project = Project.new(title: nil, user: user)

      expect(project.valid?).to be false
      expect(project.errors[:title]).to include("can't be blank")
    end
  end
  describe "validations" do
    let(:user) { User.create!(email: "user@email.com", password: "password") }

    it "is invalid without a title (nil)" do
      project = Project.new(title: nil, user: user)

      expect(project.valid?).to be false
      expect(project.errors[:title]).to include("can't be blank")
    end

    it "is invalid with an empty title ('')" do
      project = Project.new(title: "", user: user)

      expect(project.valid?).to be false
      expect(project.errors[:title]).to include("can't be blank")
    end

  
  end

end
