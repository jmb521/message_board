class UsersController < ApplicationController
before_action :set_user
  def new
    @user = User.new
    @profile = Profile.new(user_id: params[:id])
  end

  def create
    
    @user = User.find_by(email: params[:email]) || User.new(user_params) #not sure i this is necessary
      if @user.password == @user.password_confirmation
        if @user.save
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
