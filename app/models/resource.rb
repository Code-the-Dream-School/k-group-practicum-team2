class Resource < ApplicationRecord
  belongs_to :user

  # track users who bookmarked this resource
  has_many :bookmarked_resources, dependent: :destroy
  has_many :favorited_by, through: :bookmarked_resources, source: :user
end
