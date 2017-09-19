class OrdersController < ApplicationController
  before_action :authenticate_user!  
  def new
    @cart = Cart.find(session[:cart_id])
    @order = Order.new
  end

end
