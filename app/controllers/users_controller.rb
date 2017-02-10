class UsersController < ApplicationController
before_action :set_user


  def new
    @user = User.new
    @profile = Profile.new
  end

  def create
    if @user = User.find_by(email: params[:email]) ==  nil
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to posts_path
      else
        redirect_to login_path
      end
    else
      session[:user_id] = @user.id
      redirect_to posts_path
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
