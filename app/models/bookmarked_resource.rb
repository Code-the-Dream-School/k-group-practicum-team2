class BookmarkedResource < ApplicationRecord
  belongs_to :user
  belongs_to :resource

  validates :resource_id, uniqueness: { scope: :user_id }
end
