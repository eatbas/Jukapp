Rails.application.routes.draw do
  devise_for :users

  resources :rooms, only: [:create, :show] do
    collection do
      get :leave
    end
    member do
      get :join
    end
  end

  resources :video_events, path: 'statistics', only: :index
  resources :favorites, only: [:index, :create, :destroy]

  post "/socket"   => "queued_videos#socket", as: :queue_socket
  post "/queue" => "queued_videos#queue", as: :queue_video
  get "/play"   => "queued_videos#play", as: :play_video
  get "/next"   => "queued_videos#next", as: :next_video
  get "/search" => "videos#search", as: :search_videos
  get "/pings/ping" => "pings#ping"
  get "/settings" => "settings#index", as: :settings

  root "videos#search"
end
