Rails.application.routes.draw do
  root to: 'visitors#index'
  
  devise_for :users, skip: [:registrations]
  
  resources :leads, only: [:new, :create, :show, :index, :destroy] do
    collection do
      put :update_status
    end
  end

  resources :coupons, only: [:show, :index] do
    collection do
      put :generate_coupons
    end
  end

  resources :locations, only: [:show, :new, :create, :index]

  resources :haryali_locations, only: [:edit, :update]

  resources :plants

  resources :updates, only: [:new, :create]
end
