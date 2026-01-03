class CreateBookmarkedResources < ActiveRecord::Migration[8.1]
  def change
    create_table :bookmarked_resources do |t|
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
