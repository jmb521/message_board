class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorize, :logged_in?, :is_admin?, :is_moderator?, :is_owner?
  before_action :current_user
  # before_action :authorize, except: [:new, :create, :home]
  def home

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

  def is_admin?

    current_user.admin
  end

  def is_moderator?
    current_user.moderator
  end

  def set_user
    @user = current_user
  end




end
