class SessionsController < ApplicationController
  def create

    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])

      session[:user_id] = @user.id

      redirect_to posts_path
    else
      redirect_to login_path

    end
  end



  def omniauth_create
    user = User.find_by(:email => auth['info']['email'])
    if user != nil
      @profile = Profile.find_by(user_id: user.id)
      @profile.photo_url ||= auth['info']['image']
      @profile.save
      session[:user_id] = user.id
      redirect_to posts_path
    else
      redirect_to signup_path
    end

  end

  def auth
    request.env['omniauth.auth']

  end














  def new
    @user = User.new

  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
