class ProjectSkill < ApplicationRecord
  belongs_to :project
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :project_id }
end
