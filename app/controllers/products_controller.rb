class ProductsController < ApplicationController
  layout :custom_layout

  def index
    @prices_from = [1.0, 5.0, 10.0, 20.0]
    @prices_to = [25.0, 30.0, 40.0, 50.0]
    @categories = Category.all

    @from = params[:price_from]
    @to = params[:price_to]
  #  if params[:category_id].present?
    @category_id = params[:category_id]
  #  @products = Product.paginate(page: params[:page]).category_id(@category_id)
  #  elsif params[:search].present?
  #  @products = Product.paginate(page: params[:page]).search(params[:search]) 
  #  else
  #    @products = Product.paginate(page: params[:page]).all
  #  end
    @products = Product.paginate(page: params[:page]).filter(params.slice(:category_id, :price_from, :price_to, :search))
  end

  def show
    @product = Product.find(params[:id])
    #@product = Product.find_by_name(params[:name]) to show url with name
    @category = @product.category

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
      flash[:success] = "Create!"
    else
      render :new
      flash[:warning] = "STWR"
    end
  end

  def edit
    @product=Product.find(params[:id])
  end

  def update
    @product=Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
      flash[:success] = "Update success"
    else
      render :new
      flash[:warning] = "Something went wrong"
    end
  end

  def category
    @category = Category.find_by_name(params[:category_name])
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to admin_products_path
      flash[:success] = "Deleted!"
    else
      flash[:warning] = "Something went wrong!"
    end
  end

  def custom_layout
    case action_name
    when "new", "edit"
      "admin"
    when "index", "show"
      "application"
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :available_quantity, :image_file, :company_id, :category_id, :brand_id)
  end
end
