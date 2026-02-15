class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    bookmarked_projects = current_user.bookmarked_projects.includes(project: :project_skills)
    @bookmarked_projects = bookmarked_projects.map(&:project)
    @project_bookmark_ids = bookmarked_projects.pluck(:project_id, :id).to_h

    bookmarked_resources = current_user.bookmarked_resources
    @bookmarked_resources = bookmarked_resources.map(&:resource)
    @resource_bookmark_ids = bookmarked_resources.pluck(:resource_id, :id).to_h
  end
end
