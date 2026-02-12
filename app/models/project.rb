class Project < ApplicationRecord
  belongs_to :user

  # track users who bookmarked this project
  has_many :bookmarked_projects, dependent: :destroy
  has_many :favorited_by, through: :bookmarked_projects, source: :user

  # project_skills associations (based on ProjectSkill plan)
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  enum :status, {
    mentors: 0,
    teammates: 1,
    both: 2,
    closed: 3
  }

  def self.options_for_select
    {
      mentors: "Looking for mentors",
      teammates: "Looking for teammates",
      both: "Looking for both",
      closed: "Closed"

    }
  end
  validates :skills, presence: true
  validates :title, presence: true
  validates :status, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
end
