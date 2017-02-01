class UsersController < ApplicationController
  before_action :authenticate_user, only:[:index, :show, :edit]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.password == @user.password.confirmation
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user, notice: "User created successfully")
      else
        render 'new'
      end
    end
  end



  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
