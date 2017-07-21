Rails.application.routes.draw do
  root to: 'visitors#index'
  
  devise_for :users, skip: [:registrations]
  
  resources :leads, only: [:new, :create, :show]

  resources :coupons, only: [:show]

  resources :locations, only: [:show, :new, :create, :index]

  resources :haryali_locations, only: [:edit, :update]

  resources :plants, only: [:show, :new, :create, :edit, :update, :index]
end
