class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at ASC')
  end

  def show
    @product = Product.find_by_name(params[:product_name])
    @category = @product.category

  end

  def category
    @category = Category.find_by_name(params[:category_naem])
  end
end
