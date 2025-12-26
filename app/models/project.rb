class Project < ApplicationRecord
  belongs_to :user

  # track users who bookmarked this project
  has_many :bookmarked_projects, dependent: :destroy
  has_many :favorited_by, through: :bookmarked_projects, source: :user

  # tech stack associations (based on ProjectSkill plan)
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills
end
