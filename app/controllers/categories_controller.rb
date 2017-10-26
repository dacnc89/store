class CategoriesController < ApplicationController
  layout "admin"

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
      flash[:success] = "Created category"
    else
      render :new
      flash[:warning] = "Error!"
    end    
  end
  

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end
  private
  def category_params
    params.require(:category).permit(:name)
  end
end
