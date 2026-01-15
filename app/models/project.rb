class Project < ApplicationRecord
  belongs_to :user

  # track users who bookmarked this project
  has_many :bookmarked_projects, dependent: :destroy
  has_many :favorited_by, through: :bookmarked_projects, source: :user

  # tech stack associations (based on ProjectSkill plan)
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  enum :status, {
    looking_for_mentors: 0,
    looking_for_teammates: 1,
    looking_for_both: 2,
    closed: 3
  }

  validates :title, presence: true
end
