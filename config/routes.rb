Rails.application.routes.draw do
  root to: 'products#index'
  get 'admin', to: 'admins#index', as: 'admin'
  get 'admin/orders', to: 'admins#orders', as: 'admin_orders'
  get 'admin/products', to: 'admins#products', as: 'admin_products'
  get 'admin/categories', to: 'admins#categories', as: 'admin_categories'
  get 'admin/customers', to: 'admins#customers', as: 'admin_customers'

  devise_for :admins
  devise_for :users
  get 'about',  to: 'pages#about'
  get 'faqs',   to: 'pages#faqs'
  get 'products/index'
  get 'products', to: 'products#index'
  delete 'admin/products/:id', to: 'products#destroy', as: 'admin_destroy_product'
  get 'admin/product/:id', to: 'products#edit', as: 'admin_edit_product'
  patch 'admin/product/:id', to: 'products#update', as: 'admin_update_product'
  post 'admin/products', to: 'products#create', as: 'admin_create_product'
  get 'admin/products/new', to: 'products#new', as: 'admin_new_product'
  # For destroy user
  delete 'admin/customers/:id', to: 'users#destroy', as: 'admin_destroy_customer'


  #resources :products
#  get '/:brand_name/:amount', to: 'pages#brand'
  get '/category/:category_id', to: 'pages#category', as: 'category'
  get '/category', to: 'categories#new',  as: 'new_category'
  post '/admin/categories', to: 'categories#create'
  delete 'category/:id', to: 'categories#destroy'

  get 'product/:id', to: 'products#show', as: 'product'

  #get order item
  get '/order_items/:id', to: 'order_items#show' 
  #create order item when click add to cart button
  post '/order_items', to: 'order_items#add_order_item'
  #update order item when click or change number of quantity in cart
  patch '/order_items', to: 'order_items#update' 
  delete '/order_items/:id', to: 'order_items#destroy'

  get 'pages/index'
  get '/cart/:id', to: 'carts#show', as: 'cart'

  get 'checkout/:id', to: 'orders#show', as: 'order'
  get 'checkout', to: 'orders#new', as: 'new_order'
  post 'checkout', to: 'orders#create', as: 'orders'
  delete 'admmin/orders/:id', to: 'orders#destroy', as: 'admin_destroy_order'


  patch 'checkout/edit_address', to: 'ship_addresses#update', as: 'ship_address'
  post 'checkout/create_address', to: 'ship_addresses#create', as: 'ship_addresses'

  #get '/orders', to: 'orders#index', as: 'orders'
  #post '/order/:id', to: 'orders#show'
  post '/hook', to: 'orders#hook'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
