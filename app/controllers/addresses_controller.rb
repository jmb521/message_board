class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def show
    @address = Address.find_by(id: params[:id])
  end

  def create
    @address = Address.new

  end

  def edit
    @address = Address.find_by(id: params[:id])

  end

  def update
    @address = Address.find_by(id: params[:id])
    @address.update(address_params)

  end


  private

    def address_params
      params.require(:address).permit(:address1, :address2, :city, :state, :zipcode, :user_id, :profile_id)
    end
end
