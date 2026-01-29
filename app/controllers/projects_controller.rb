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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update(project_params)
      redirect_to @project, notice: "#{@project.title} has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy

    redirect_to projects_path, notice: "Project has been deleted."
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status, :url, skill_ids: [])
  end
end
