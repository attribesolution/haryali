Rails.application.routes.draw do
  root to: 'haryali_locations#index'
  
  devise_for :users, skip: [:registrations], :controllers => {sessions: 'sessions'}
  
  resources :leads, only: [:new, :create, :show, :index, :destroy] do
    collection do
      put :update_status
      post :update_detail
      post :timeline_event
      get :archive
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

  resources :haryali_yaads, only: [:index] do
    collection do
      put :submit_form
    end
  end

  get 'yaad' => "haryali_yaads#index"

  namespace :haryali_location_api, defaults: { format: :json } do
    namespace :v1 do
      resources :haryali_locations, only: [:index, :show]
    end
  end
end
