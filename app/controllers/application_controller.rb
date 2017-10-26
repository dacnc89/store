class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :set_cart
  layout :layout_by_resource

  after_action :store_location
  protect_from_forgery with: :exception
  helper_method :current_cart
  def store_location
    return unless request.get?
    if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def current_cart
    @cart ||= Cart.find(session[:cart_id])
  end

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end

end
