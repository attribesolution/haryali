Rails.application.routes.draw do
  root to: 'haryali_locations#index'
  
  devise_for :users, skip: [:registrations], :controllers => {sessions: 'sessions'}
  
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

  resources :haryali_locations, only: [:edit, :update, :index]

  resources :plants

  resources :updates, only: [:new, :create]

  resources :visitors, only: [:index, :show]

  resources :haryali_yaads, only: [:index]
end
