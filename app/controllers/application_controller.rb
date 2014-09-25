class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_room_exists

  def ensure_in_room
    redirect_to rooms_path, notice: "First you have to join a room." unless current_room
  end

  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end

  def ensure_room_exists
    current_room
  rescue ActiveRecord::RecordNotFound
    session[:current_room_id] = nil
    redirect_to :rooms, alert: "The room you were in has been deleted."
  end

end
