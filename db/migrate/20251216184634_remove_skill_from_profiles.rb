class RemoveSkillFromProfiles < ActiveRecord::Migration[8.1]
  def change
    remove_column :profiles, :skill, :string
  end
end
