class Profile < ApplicationRecord
  belongs_to :user

  has_many :profile_skills, dependent: :destroy
  has_many :skills, through: :profile_skills
  has_one_attached :avatar

  validates :first_name, :last_name,  :skill_level, presence: true
end
