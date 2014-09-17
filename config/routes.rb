Rails.application.routes.draw do
  resources :videos, only: :create do
    collection do
      get :search
      get :play
    end
  end

  root "videos#search"
end
