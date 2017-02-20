class UsersController < ApplicationController
before_action :authorize, :except => [:create, :new]



  def new
    @user = User.new

  end

  def create
    if User.find_by(email: params[:email]) != nil
      flash[:alert] = "There is already an account with that email address" #used when someone creates an account with the same email address
    binding.pry
      render 'new'
      flash[:alert] = nil
    else

    @user = User.new(user_params)

      if @user.save
        session[:user_id] = @user.id
        Profile.create(user_id: @user.id)
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
    params.require(:user).permit(:username, :password, :password_confirmation, :role, :email)
  end

end
