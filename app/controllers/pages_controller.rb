class PagesController < ApplicationController
  def index
  end

  def about
  end

  def faqs
  end

  def category
    @category = Category.find_by_name(params[:category_name])
    
  end
  

  def brand

  end
end
