class Project < ApplicationRecord
  belongs_to :user

  # track users who bookmarked this project
  has_many :bookmarked_projects, dependent: :destroy
  has_many :favorited_by, through: :bookmarked_projects, source: :user

  # project_skills associations (based on ProjectSkill plan)
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  enum :status, {
    mentors: 0,
    teammates: 1,
    both: 2,
    closed: 3
  }

  validates :title, presence: true
  validates :status, presence: true
end
