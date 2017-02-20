class Admin::ManageUsersController < ApplicationController

  def index
    @users = User.all
  end


end
