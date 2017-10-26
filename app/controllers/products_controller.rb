class ProductsController < ApplicationController
  layout :custom_layout

  def index
    @products = Product.paginate(page: params[:page]).search(params[:search])
    #@cart = Cart.find(session[:cart_id])
  end

  def show
    @product = Product.find(params[:id])
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
