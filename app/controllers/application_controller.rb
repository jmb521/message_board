
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorize, :logged_in?
  before_action :current_user

  def home
    render :layout => "home"
  end

  def current_user

    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def logged_in?
    !!current_user
  end

  def set_user
    @user = current_user
  end




end
