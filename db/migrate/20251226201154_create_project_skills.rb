class CreateProjectSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :project_skills do |t|
      t.references :project, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
