Rails.application.routes.draw do
  devise_for :users
  get 'about',  to: 'pages#about'
  get 'faqs',   to: 'pages#faqs'
  get 'products/index'
  get 'products', to: 'products#index'
  #resources :products
#  get '/:brand_name/:amount', to: 'pages#brand'
  get '/:category_name/:amount', to: 'pages#category'
  get '/:product_name', to: 'products#show'


  root to: 'products#index'
  get 'pages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
