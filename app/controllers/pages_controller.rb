class PagesController < ApplicationController
  def index
  end

  def about
  end

  def faqs
  end

  def category
   # @category = Category.find_by_name(params[:category_name])
    @category  = Category.find(params[:category_id])
    @products = @category.products
    
  end
  

  def brand

  end
end
