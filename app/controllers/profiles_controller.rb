class ProfilesController < ApplicationController
  before_action :authorize, :set_user

  def show
      @profile = Profile.find_by(user_id: current_user.id)
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
