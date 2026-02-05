class BookmarkedProjectsController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    @bookmarked_project = current_user.bookmarked_projects.new(project: @project)

    if @bookmarked_project.save
      flash[:notice] = "#{@project.title} successfully bookmarked!"
    else
      flash[:alert] = "#{@project.title} failed to be saved as a bookmark."
    end

    redirect_back(fallback_location: project_path(@project))
  end

  def destroy
    bookmarked_project = current_user.bookmarked_projects.find(params[:id])
    @project = bookmarked_project.project
    bookmarked_project.destroy

    redirect_back(fallback_location: project_path(@project), notice: "Project is no longer bookmarked.")
  end
end
