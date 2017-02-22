class Admin::ManageUsersController < ApplicationController

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
    @manage_user = User.find_by(id: params[:id])

    @manage_user.update_attribute(:role, params[:user][:role])

    redirect_to admin_manage_user_path(@manage_user)
  end


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :role, :email)
  end
end
