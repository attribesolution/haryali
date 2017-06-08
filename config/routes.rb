Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :leads, only: [:new, :create, :show]

  resources :coupons, only: [:show]
end
