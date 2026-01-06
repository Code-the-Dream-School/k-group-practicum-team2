class ResourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = current_user.resources.new(resource_params)
    if @resource.save
      redirect_to resources_path, notice: 'New resource was posted!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :description, :url)
  end
end
