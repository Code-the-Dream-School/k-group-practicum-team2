class AddUrlToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :url, :string
  end
end
