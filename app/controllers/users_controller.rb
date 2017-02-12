class UsersController < ApplicationController
before_action :set_user


  def new
    @user = User.new
    @profile = Profile.new
  end

  def create

    @user = User.new(user_params)
    if User.find_by(email: @user.email) != nil
      @message = "There is already an account with that email"
      #need to figure out what I want to do. I can either redirect to the login path so that the user can attempt sign in or
      #should I just show a message saying there's already an account and leave it at that since there's already a login link on the page. 
    else
      if @user.save
        session[:user_id] = @user.id

        redirect_to posts_path
      else
        redirect_to login_path
      end
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
