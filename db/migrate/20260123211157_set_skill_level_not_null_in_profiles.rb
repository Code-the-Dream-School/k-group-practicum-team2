class SetSkillLevelNotNullInProfiles < ActiveRecord::Migration[8.1]
  def up
    Profile.reset_column_information
    Profile.where(skill_level: nil).update_all(skill_level: "junior")
    change_column_null :profiles, :skill_level, false
  end

  def down
    change_column_null :profiles, :skill_level, true
  end
end
