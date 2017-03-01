class ProfilesController < ApplicationController
  before_action :authorize, :set_profile

  def show
    if session[:user_id] != @profile.user_id
       redirect_to posts_path
    end
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    redirect_to profile_path(@profile)
  end

  def profile_pic
  end

  private
  def profile_params
    params.require(:profile).permit(:photo_url, :user_id)
  end
  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end
end
