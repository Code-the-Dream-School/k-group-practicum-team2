class ResourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @resources = Resource.all
    @bookmarked_resource_ids = current_user.bookmarked_resources.pluck(:resource_id, :id).to_h
  end

  def show
    @resource = Resource.find(params[:id])
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

  def edit
    @resource = current_user.resources.find(params[:id])
  end

  def update
    @resource = current_user.resources.find(params[:id])

    if @resource.update(resource_params)
      redirect_to resource_path(@resource), notice: "#{@resource.title} has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resource = current_user.resources.find(params[:id])
    @resource.destroy

    redirect_to resources_path, notice: "Resource has been deleted."
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :description, :url)
  end
end
