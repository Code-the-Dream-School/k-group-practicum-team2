class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # profile relationship
  has_one :profile, dependent: :destroy

  # core content created by the user
  has_many :projects, dependent: :destroy
  has_many :resources, dependent: :destroy

  # bookmark join table
  has_many :bookmarked_resources, dependent: :destroy
  has_many :bookmarked_projects, dependent: :destroy

  # shortcut associations (allow you to do @user.fav_projects to get a list of the actual projects the user bookmarked)
  has_many :fav_resources, through: :bookmarked_resources, source: :resource
  has_many :fav_projects, through: :bookmarked_projects, source: :project
end
