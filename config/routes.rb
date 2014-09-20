Rails.application.routes.draw do
  resources :videos, only: [:index, :create] do
    collection do
      get :search
      get :play
      get :next
      post :socket
    end
  end

  root "videos#search"
end
