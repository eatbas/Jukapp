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

  resources :favorites, only: [:index, :create] do
    collection do
      delete :destroy
    end
  end

  resources :queued_videos, only: [:index, :destroy]
  resources :recommended_videos, only: :index

  resources :videos, only: [:index, :create] do
    member do
      put :queue
    end
  end

  # post "/queue" => "queued_videos#queue", as: :queue_video
  get "/play"   => "queued_videos#play", as: :play_video
  get "/next"   => "queued_videos#next", as: :next_video
  get "/search" => "videos#search", as: :search_videos
  get "/ajax_search" => "videos#ajax_search", as: :ajax_search_videos
  get "/pings/ping" => "pings#ping"
  get "/settings" => "settings#index", as: :settings

  root "video_events#index"

  mount Pubsubstub::Application.new, at: "/events", as: :events
end
