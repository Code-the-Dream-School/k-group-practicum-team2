class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    bookmarked_projects = current_user.bookmarked_projects.includes(project: :project_skills)
    @bookmarked_projects = bookmarked_projects.map(&:project)
    @bookmarked_project_ids = bookmarked_projects.pluck(:project_id).to_set
  end
end
