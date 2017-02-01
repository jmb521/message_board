class SessionsController < ApplicationController


  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      redirect_to login_path
    end
  end

  def login
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
