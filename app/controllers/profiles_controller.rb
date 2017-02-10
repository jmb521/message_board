class ProfilesController < ApplicationController
  before_action :authorize, :set_user

  def show
      @profile = Profile.find_by(id: params[:id])
  end

  # def new
  #   @profile = Profile.new
  #
  # end

  def create
    @profile = Profile.create(profile_params)
    redirect_to profile_path(@profile)
  end

  def edit
    @profile = Profile.find_by(id: params[:id])
  end

  def update
    @profile = Profile.find_by(id: params[:id])
    @profile.update(profile_params)
    redirect_to profile_path(@profile)
  end


  private
  def profile_params
    params.require(:profile).permit(:photo_url, :user_id)
  end
end
