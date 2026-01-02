class ProfilesController < ApplicationController
  # Ensure user is logged in
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end


  def edit
    @skills = Skill.all
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      @skills = skill.all
      render :edit, status: :uprocessable_entity
    end
  end

  private
  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio, skill_ids: [])
  end
end
