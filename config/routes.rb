Rails.application.routes.draw do
  devise_for :users
  get 'about',  to: 'pages#about'
  get 'faqs',   to: 'pages#faqs'
  get 'products/index'
  get 'products', to: 'products#index'
  #resources :products
#  get '/:brand_name/:amount', to: 'pages#brand'
  get '/category/:category_id', to: 'pages#category', as: 'category'
  get 'product/:id', to: 'products#show', as: 'product'
  
  #create order item when click add to cart button
  post '/order_items', to: 'order_items#add_order_item'
  
  root to: 'products#index'
  get 'pages/index'
  get 'checkout/cart/details', to: 'carts#show', as: 'cart'

  get 'checkout/:id', to: 'orders#show', as: 'order'
  get 'checkout', to: 'orders#new', as: 'new_order'
  post 'checkout', to: 'orders#create', as: 'orders'
  patch 'checkout/edit_address', to: 'ship_addresses#update', as: 'ship_address'

  #get '/orders', to: 'orders#index', as: 'orders'
  #post '/order/:id', to: 'orders#show'
  post '/hook', to: 'orders#hook'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
