class UsersController < ApplicationController
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_customers_path
      flash[:success] = "Deleted!"
    else
      redirect_to admin_path
      flash[:warning] = "Some thing went wrong!"
    end

  end
end
