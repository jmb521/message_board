class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:user][:email])
    binding.pry
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
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
