Rails.application.routes.draw do
  get "search" => 'videos#search'

  root "videos#search"
end
