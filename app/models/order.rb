class Order < ApplicationRecord
  has_many    :order_items
  has_many    :products, through: :order_items
  has_one     :ship_adress


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

  
end 
