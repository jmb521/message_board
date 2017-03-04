class AddressesController < ApplicationController
  before_action :authorize, :set_address
  def new
    @address = Address.new(profile_id: params[:profile_id])
  end

  def show

  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save

      redirect_to profile_address_path(@address.profile, @address)
    end
  end

  def edit
  end

  def update
    @address.update(address_params)

    redirect_to profile_address_path(@address.profile_id, @address)
  end


  private

    def address_params
      params.require(:address).permit(:address1, :address2, :city, :state, :zipcode, :user_id, :profile_id)
    end

    def set_address
      @address = Address.find_by(id: params[:id])
    end
end
