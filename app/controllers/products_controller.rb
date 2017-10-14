class ProductsController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page]).search(params[:search])
    #@cart = Cart.find(session[:cart_id])
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.category

  end

  def category
    @category = Category.find_by_name(params[:category_naem])
  end
end
