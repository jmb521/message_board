class ProfilesController < ApplicationController
  before_action :authenticate_user, :set_user
end
