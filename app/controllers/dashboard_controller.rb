class DashboardController < ApplicationController
  # before_action :authenticate_user!
  # will uncomment once login feature is ready

  def index
    @user = current_user
  end
end
