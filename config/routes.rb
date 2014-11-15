Rails.application.routes.draw do
  devise_for :users

  resources :rooms, only: [:create, :show, :destroy] do
    collection do
      get :leave
    end
    member do
      get :join
    end
  end

  resources :video_events, path: 'statistics', only: :index
  resources :favorites, only: [:index, :create] do
    collection do
      delete :destroy
    end
  end

  resources :queued_videos, only: [:index, :destroy]
  resources :recommended_videos, only: :index

  post "/socket"   => "queued_videos#socket", as: :queue_socket
  post "/queue" => "queued_videos#queue", as: :queue_video
  get "/play"   => "queued_videos#play", as: :play_video
  get "/next"   => "queued_videos#next", as: :next_video
  get "/search" => "videos#search", as: :search_videos
  get "/ajax_search" => "videos#ajax_search", as: :ajax_search_videos
  get "/pings/ping" => "pings#ping"
  get "/settings" => "settings#index", as: :settings

  root "recommended_videos#index"
end
