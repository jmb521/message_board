class Admin::ManageUsersController < ApplicationController
  before_action :set_user
  def index
    @manage_users = User.all
  end

  def show
    @manage_user = User.find_by(id: params[:id])
  end

  def edit
    @manage_user = User.find_by(id: params[:id])
  end

  def update


    @manage_user.update_attribute(:role, params[:user][:role])

    redirect_to admin_manage_user_path(@manage_user)
  end


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :role, :email)
  end

  def set_user
    @manage_user = User.find_by(id: params[:id])
  end
end
