class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :trackable, :validatable



  def self.get_total_money_in_orders
    result = 0.0
    list_orders = Order.all
    list_orders.each do |order|
      result += order.fee_amount
    end
    return result
  end
end
