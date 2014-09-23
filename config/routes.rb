Rails.application.routes.draw do
  resources :rooms, only: [:index, :create, :show] do
    collection do
      get :leave
    end
    member do
      get :join
    end
  end

  post "/socket"   => "queued_videos#socket", as: :queue_socket
  post "/queue" => "queued_videos#queue", as: :queue_video
  get "/play"   => "queued_videos#play", as: :play_video
  get "/next"   => "queued_videos#next", as: :next_video
  get "/search" => "videos#search", as: :search_videos
  get "/pings/ping" => "pings#ping"

  root "rooms#index"
end
