class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_in_room
    redirect_to rooms_path unless current_room
  end

  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end
end
