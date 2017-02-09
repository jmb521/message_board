class ProfilesController < ApplicationController
  before_action :authorize, :set_user

  def show
      @profile = Profile.find_by(user_id: current_user.id)
  end

  # def new
  #   @profile = Profile.new
  #
  # end

  def create
    @profile = Profile.create(profile_params)
    redirect_to profile_path(@profile)
  end


  private
  def profile_params
    params.require(:profile).permit(:url, :user_id)
  end
end
