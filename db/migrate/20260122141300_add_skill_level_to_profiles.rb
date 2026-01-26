class AddSkillLevelToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :skill_level, :string
  end
end
