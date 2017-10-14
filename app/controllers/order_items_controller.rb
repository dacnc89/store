class OrderItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :add_order_item
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]


  def show
    respond_to do |format|
      format.json {render json: {quantity: @order_item.quantity}}
    end
  end
  
  def add_order_item
    @product = Product.find(params[:id])
    @order_item = @cart.add_order_item(params[:id])
    
    if @order_item.save && @cart.save
      @order_items = @cart.order_items
      respond_to do |format|
        format.json {render json: {product: @product, order_item: @order_item} }
      end
    else
      respond_to do |format|
        format.json {render json: @order_item.errors}
        format.html do
          redirect_to  products_path
          flash[:warning] = @order_item.errors
        end
      end
    end
  end
  
  def update
    quantity = params[:quantity]
    if @order_item.update(quantity: params[:quantity])
      respond_to do |format|
    format.json {render json: {quantity: @order_item.quantity, price: @order_item.price_line}}
      end
    end    
  end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.json {render json: {message: "Deleted order item", id: @order_item.id}}
    end
  end


  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end


  private
  def order_item_params
    params.require(:order_item).permit(:product_id)
  end
end
