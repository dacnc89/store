class OrdersController < ApplicationController
  before_action :authenticate_user! , only: [:show, :new, :create]

  protect_from_forgery except: [:hook]


  def hook
    params.permit! # Permit all Pypal input params
    satus = params[:payment_status]
    if status == "Completed"
      @order = Order.find(params[:invoice])
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end


    
  def show
    @order = Order.find(params[:id])
    @addr = ShipAddress.find(@order.ship_address_id)
  end


  def new
    @order = Order.new
    @order.build_card
    @cart = Cart.find(session[:cart_id])
    @ship_address = current_user.ship_address 
    
  end

  def create
    @order = Order.new(order_params)
    order_number = Order.generate_order_number
    @order.order_number = order_number
    current_cart.pass_order_item_from_cart(@order)
    @ship_address = current_user.ship_address

    case params[:order][:paytype]
    when "card"
      @order.card.ip_address = request.remote_ip
      if @order.save
        current_cart.destroy
        if @order.card.purchase
          redirect_to order_path(@order), notice: @order.card.card_transaction.message
          flash[:warning] = "Some thing went wrong during delete this order!"
        else
          redirect_to order_path(@order), alert: @order.card.card_transaction.message
        end
      else
        render :new
      end
    when "cash"
      if @order.save
        current_cart.destroy
        redirect_to order_path(@order)
        flash[:success] = "Successful inform from shopping online with cash paytype"
      else
        render :new
      end
    when "paypal"
      if @order.save
        current_cart.destroy
        redirect_to @order.paypal_url(order_path(@order))
      else
        render :new
      end
    end
  end 

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      redirect_to admin_orders_path
      flash[:success] = "Deleted"
    else
      redirect_to admin_orders_path
      flash[:warning] = "Something went wrong"
    end
  end

  private 
  def order_params
    case params[:order][:paytype]
    when "cash"
      params.require(:order).permit(:paytype, :ship_address_id, :fee_amount)
    when "paypal"
      params.require(:order).permit(:paytype, :ship_address_id)
    when "card"
      params.require(:order).permit(:ship_address_id, :fee_amount, card_attributes: [:first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on])
    end
  end

end
