require "rails_helper"

RSpec.describe Project, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:owner) { User.create!(email: "owner@example.com", password: "password") }
  let(:favoriter) { User.create!(email: "fan@example.com", password: "password") }
  let(:skill) { Skill.create!(name: "Ruby") }

  describe "associations" do
    it "belongs to a user" do
      project = Project.create!(title: "Test Project", user: user, status: :mentors, skills: [ skill ])

      expect(project.user).to eq(user)
    end

    it "can have many skills through project_skills" do
      project = Project.create!(title: "Test Project", user: user, status: :mentors, skills: [ skill ])

      skill1 = Skill.create!(name: "Rails")
      skill2 = Skill.create!(name: "React")

      project.skills << skill1
      project.skills << skill2

      expect(project.skills).to include(skill1, skill2)
    end

    it "tracks users who bookmarked the project" do
      project = Project.create!(title: "Test Project", user: owner, status: :mentors, skills: [ skill ])
      BookmarkedProject.create!(user: favoriter, project: project)

      expect(project.favorited_by).to include(favoriter)
    end

    it "destroys associated project_skills when deleted" do
      project = Project.create!(title: "Test Project", user: user, status: :mentors, skills: [ skill ])




      expect { project.destroy }.to change(ProjectSkill, :count).by(-1)
    end
    it "destroys associated bookmarked_projects when deleted" do
      project = Project.create!(title: "Test Project", user: owner, status: :mentors, skills: [ skill ])
      project.bookmarked_projects.create!(user: user)

      expect { project.destroy }.to change(BookmarkedProject, :count).by(-1)
    end
  end


  describe "validations" do
    it "is invalid with an empty title ('')" do
      project = Project.new(title: "", user: user, status: :mentors, skills: [ skill ])

      expect(project.valid?).to be false
      expect(project.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a title - nil" do
      project = Project.new(title: nil, user: user, status: :mentors, skills: [ skill ])

      expect(project.valid?).to be false
      expect(project.errors[:title]).to include("can't be blank")
    end

    it "is valid with a nil url" do
      project = Project.new(
        title: "My Project",
        url: nil,
        user: user,
        status: :mentors,
        skills: [ skill ]
      )
      expect(project).to be_valid
    end
    it "is valid with an empty url" do
      project = Project.new(
        title: "My Project",
        url: "",
        user: user,
        status: :mentors,
        skills: [ skill ]
      )

      expect(project).to be_valid
    end

    it "is invalid with a malformed url" do
      project = Project.new(
        title: "My Project",
        url: "not-a-url",
        user: user,
        status: :mentors,
        skills: [ skill ]
      )

      expect(project).not_to be_valid
      expect(project.errors[:url]).to include("is invalid")
    end

    it "is valid,  properly formatted url" do
      project = Project.new(
        title: "My Project",
        url: "https://example.com",
        user: user,
        status: :mentors,
        skills: [ skill ]
      )

      expect(project).to be_valid
    end
    it "is invalid with a non-http/https protocol" do
      project = Project.new(
        title: "Test Project",
        status: :mentors,
        user: user,
        url: "ftp://example.com",
        skills: [ skill ]
      )

      expect(project).to be_invalid
      expect(project.errors[:url]).to be_present
    end
  end
  it "is invalid without any skills" do
    project = Project.new(
      title: "Test Project",
      user: user,
      status: :mentors,
      skills: []
    )

    expect(project).not_to be_valid
    expect(project.errors[:skills]).to include("can't be blank")
  end
end
