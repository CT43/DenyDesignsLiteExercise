Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :orders , only: [:new, :create]
  resources :products
  resources :vendors
  resources :product_vendor_allocations, only: [:new, :create]

end
