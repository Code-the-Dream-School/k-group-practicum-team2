class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skills, only: [ :new, :edit ]
  before_action :set_user_profile, only: [ :edit, :update ]


  def index
    if current_user.profile
      @profiles = Profile.all.where.not(id: current_user&.profile.id)
    else
      @profiles = Profile, all
    end
  end

  def new
    @profile = current_user.profile || current_user.build_profile
  end
  def create
    @profile = current_user.profile || current_user.build_profile

    if @profile.update(profile_params)

      redirect_to user_profile_path(current_user.id, @profile.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @user = User.find(params[:user_id])
    @user_projects = @user.projects
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(current_user.id, @profile.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @profile = current_user.profile
  #   @profile.destroy!
  #   redirect_to user_profiles_path(current_user)
  # end


  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio, :avatar, skill_ids: [])
  end
  def set_skills
    @skills = Skill.all
  end
  def set_user_profile
    @profile = current_user.profile
  end
end
