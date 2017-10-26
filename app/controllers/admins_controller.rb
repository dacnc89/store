class AdminsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!




  def index
    @orders = Order.order(:created_at)
    @categories = Category.search(params[:search])
  end


  def orders
    @orders = Order.paginate(page: params[:page]).search(params[:search])
  end

  def products
    @products = Product.paginate(page: params[:page]).search(params[:search])
  end

  def categories
    @categories = Category.search(params[:search])
  end

  def customers
    @customers = User.paginate(page: params[:page]).search(params[:search])
  end
end
