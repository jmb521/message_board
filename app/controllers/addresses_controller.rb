class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  

  def create
    @address = Address.new

  end

  def edit

  end

  def update

  end


  private

    def address_params

    end
end
