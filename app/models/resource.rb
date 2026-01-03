class Resource < ApplicationRecord
  belongs_to :user

  # track users who bookmarked this resource
  has_many :bookmarked_resources, dependent: :destroy
  has_many :favorited_by, through: :bookmarked_resources, source: :user

  validates :title, presence: true
  validates :url, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end
