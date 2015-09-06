Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :rooms, only: [:index, :create, :show, :destroy] do
    collection do
      get :leave
    end
    member do
      get :join
    end
  end

  resources :video_events, path: 'statistics', only: :index
  get "/stats" => "video_events#stats"

  resources :queued_videos, only: [:index, :destroy]
  resources :recommended_videos, only: :index

  resources :favorites, param: :youtube_id, only: [:index, :create, :destroy]

  get "/jukebox" => "videos#jukebox", as: :jukebox
  get "/play" => "videos#play", as: :play_video
  resources :videos, param: :youtube_id, only: :index do
    member do
      put :queue
      put :dequeue
      put :prioritize
      put :deprioritize
      put :pause
      put :continue
    end
  end

  # post "/queue" => "queued_videos#queue", as: :queue_video
  get "/next"   => "queued_videos#next", as: :next_video
  get "/search" => "videos#search", as: :search_videos
  get "/ajax_search" => "videos#ajax_search", as: :ajax_search_videos
  get "/pings/ping" => "pings#ping"
  get "/settings" => "settings#index", as: :settings

  root "videos#jukebox"

  mount Pubsubstub::Application.new, at: "/events", as: :events
end
