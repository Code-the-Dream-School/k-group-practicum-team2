class RemoveTechStackFromProjects < ActiveRecord::Migration[8.1]
  def change
    remove_column :projects, :tech_stack, :text
  end
end
