Rails.application.routes.draw do
  resources :videos, only: :create do
    collection do
      get :search
      get :play
      get :next
    end
  end

  root "videos#search"

  post "eshq/socket" => "videos#open_socket"
end
