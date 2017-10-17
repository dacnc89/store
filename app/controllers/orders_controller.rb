class OrdersController < ApplicationController
  
  before_action :authenticate_user! #, :set_cart

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
    @order.card.ip_address = request.remote_ip
    order_number = Order.generate_order_number
    @order.order_number = order_number
    current_cart.pass_order_item_from_cart(@order)
    #@order.fee_amount = current_cart.amount
    #@order.pass_order_item_from_cart
    
    #@order.ship_address_id = current_user.ship_address.id
    if @order.save
      current_cart.destroy
      case params['paytype']
        when "card"
          if @order.card.purchase
            redirect_to order_path(@order), notice: @order.card.card_transaction.message
          else
            redirect_to order_path(@order), alert: @order.card.card_transaction.message
          end
        when "paypal"
          redirect_to @order.paypal_url(order_path(@order))
        when "cash"
          redirect_to order_path(@order)
          flash[:success] = "Successful inform from shopping online"
        end
    
    else
      render :new
    end
  end 


  private 
  def order_params
      params.require(:order).permit(:ship_address_id, :fee_amount, card_attributes: [:first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on])
  end

  def card_params
    params.require(:card).permit(:first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on)
  end

end
