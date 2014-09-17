Rails.application.routes.draw do
  get "search" => 'videos#search', as: :search_songs

  root "videos#search"
end
