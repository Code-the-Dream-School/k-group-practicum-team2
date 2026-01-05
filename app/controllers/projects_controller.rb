class ProjectsController < ApplicationController
  # Ensure user is logged in
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to projects_path, notice: 'New project was created!'
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
