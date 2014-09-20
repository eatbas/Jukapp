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

  post "/queue" => "queued_videos#queue", as: :queue_video
  get "/play"   => "queued_videos#play", as: :play_video
  get "/next"   => "queued_videos#next", as: :next_video

  root "rooms#index"
end
