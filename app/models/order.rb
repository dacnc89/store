class Order < ApplicationRecord
  validates :ship_address_id, presence: true
  
  before_save :unique_on
  has_many    :order_items
  has_many    :products, through: :order_items
  has_one     :ship_adress
  has_one     :card
  accepts_nested_attributes_for :card
  validates_associated :card

  def self.generate_order_number

    g_number = ""
    date = DateTime.now.strftime("%Y%m%d");
    char =  ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9"] 
    char1 = char.sample
    char2 = char.sample
    char3 = char.sample
    char4 = char.sample
    g_number += date + char1 + char2 + char3 + char4
    
    order_number = g_number
  end

  def unique_on
    if self[:order_number] == nil
      temp = Order.generate_order_number
      order_number_list = []
      orders = Order.all
      orders.each do |od|
        order_number_list.push(od.order_number)
      end
      while order_number_list.include?(temp) do
        temp = Order.generate_order_number
      end
      self[:order_number] = temp
    end
  end

  def pass_order_item_from_cart
      current_cart.order_items.each do |item|
      order_items.push(item)
    end
  end


#  def paypal_url(return_path)
#    values = {
#      business: "congdacit-facilitator@gmail.com",
#      cmd: "_xclick",
#      upload: 1,
#      return: "#{Rails.application.secrets.app_host}#{return_path}",
#      invoice: id,
#      notify_url: "#{Rails.application.secrets.app_host}/hook",
#        amount: fee_amount,
#        quantity: '1',
#        item_name: 'bla1',
#    }
#    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?"+values.to_query
#  end


    # for order_items
    #
  def paypal_url(return_path)
    values = {
      shippingAdress: ShipAddress.find(ship_address_id),
      business: "congdacit-facilitator@gmail.com",
      cmd: "_cart",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    order_items.each_with_index do |item, index|
      product = Product.find(item.product_id)
      values.merge!(
        "amount_#{index+1}" => product.price,
        "quantity_#{index+1}" =>"#{item.quantity}",
        "item_name_#{index+1}" => product.name
      )
    end
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  
  end




end 
