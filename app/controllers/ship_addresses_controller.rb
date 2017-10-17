class ShipAddressesController < ApplicationController


  def new
    @ship_address = ShipAddress.new
  end

  def create
    @ship_address = ShipAddress.new(address_params)
    if @ship_address.save
      respond_to do |format|
        format.html { redirect_to new_order_path}
        format.json { render json: @ship_address}
      end
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
  

  def destroy
    @ship_address = ShipAdress.find(ship_address_id)
    @ship_address.destroy
  end
  private
  def address_params
    params.require(:ship_address).permit(:name, :city, :district, :ward, :details, :user_id)
  end
end
