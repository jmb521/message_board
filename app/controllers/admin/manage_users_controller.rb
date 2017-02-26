class Admin::ManageUsersController < ApplicationController
  before_action :set_user
  before_filter :for_admin_and_moderator_only
  def index
    @manage_users = User.all
  end

  def show
  end

  def edit
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

    def for_admin_and_moderator_only
      if !current_user.admin? || !current_user.moderator?
        redirect_to posts_path
      end
    end
end
