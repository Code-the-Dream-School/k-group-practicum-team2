class Skill < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :profile_skills, dependent: :destroy
  has_many :profiles, through: :profile_skills

  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills
end
