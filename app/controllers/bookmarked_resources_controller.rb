class BookmarkedResourcesController < ApplicationController
  before_action :authenticate_user!

  def create
    @resource = Resource.find(params[:resource_id])
    @bookmarked_resource = current_user.bookmarked_resources.new(resource: @resource)

    if @bookmarked_resource.save
      flash[:notice] = "#{@resource.title} successfully bookmarked!"
    else
      flash[:alert] = "#{@resource.title} failed to be saved as a bookmark."
    end

    redirect_back(fallback_location: resource_path(@resource))
  end

  def destroy
    bookmarked_resource = current_user.bookmarked_resources.find(params[:id])
    @resource = bookmarked_resource.resource


    if bookmarked_resource.destroy
      flash[:notice] = "Resource is no longer bookmarked."
    else
      flash[:alert] = "The bookmark for #{@resource.title} failed to be deleted."
    end

    redirect_back(fallback_location: resource_path(@resource))
  end
end
