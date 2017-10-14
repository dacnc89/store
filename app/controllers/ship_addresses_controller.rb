class ShipAddressesController < ApplicationController


  def new
    @ship_address = ShipAddress.new
  end

  def create
    @ship_address = ShipAddress.new(address_params)
    if @ship_address.save
      render json: @ship_address
    else
      render json: {error: @ship_address.errors}
    end
  end


  def update
    id = current_user.ship_address.id
    @ship_address = ShipAddress.find(id)
    respond_to do |format|
      if @ship_address.update(address_params)
        format.html { flash[:success] = "Updated!"}
        format.js
        format.json { render json: @ship_address }
      else
        format.json { render json: @ship_address.errors }
      end
    end
  end

  private
  def address_params
    params.require(:ship_address).permit(:name, :city, :district, :ward, :details, :user_id)
  end
end
