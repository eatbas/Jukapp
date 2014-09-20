Rails.application.routes.draw do
  resources :videos, only: [:index, :create] do
    collection do
      get :search
      get :play
      get :next
      post :socket
    end
  end

  resources :rooms, only: [:index, :create, :show] do
    collection do
      get :leave
    end
    member do
      get :join
    end
  end

  root "rooms#index"
end
