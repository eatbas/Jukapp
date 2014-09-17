Rails.application.routes.draw do
  resources :videos, only: :create do
    collection do
      get :search
    end
  end

  root "videos#search"
end
