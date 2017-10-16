class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :show
  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      flash[:success] = "Created cart"
      session[:cart_id] = @cart.id
      redirect_to root_path
    else
      flash[:warning] = "cann't create cart"
    end
  end
    

    def show
    end

    private
    def cart_params
      params.fetch(:cart, {})
    end
end
