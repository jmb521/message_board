class AddressesController < ApplicationController
  before_action :authorize
  def new

    @address = Address.new(profile_id: params[:profile_id])
  end

  def show
    @address = Address.find_by(id: params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save

      redirect_to profile_address_path(@address)
    end


  end

  def edit
    @address = Address.find_by(id: params[:id])

  end

  def update
    @address = Address.find_by(id: params[:id])
    @address.update(address_params)
    binding.pry
    redirect_to profile_address_path(@address.profile_id, @address.user_id)
  end


  private

    def address_params
      params.require(:address).permit(:address1, :address2, :city, :state, :zipcode, :user_id, :profile_id)
    end
end
