class CreateResources < ActiveRecord::Migration[8.1]
  def change
    create_table :resources do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
