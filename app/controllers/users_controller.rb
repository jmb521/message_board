class UsersController < ApplicationController
before_action :set_user
validates :email, confirmation: true
  def new
    @user = User.new
    @profile = Profile.new(user_id: params[:id])
  end

  def create
    if params[:password] == params[:password_confirmation]
      @user = User.find_or_create_by(email: params[:email])
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render 'new'
      end
      else
        redirect_to login_path
      end

  end

  def show
    @user = User.find_by(id: params[:id])
  end



  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :admin, :email)
  end

end
