class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_room_exists

  def ensure_in_room
    unless current_room
      if Rails.env == "production"
        session[:current_room_id] = 4 # 27 Confederation
        redirect_to :back, notice: "Welcome to the haunted house."
      else
        redirect_to settings_path, notice: "First you have to join a room."
      end
    end
  end

  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end

  def ensure_room_exists
    current_room
  rescue ActiveRecord::RecordNotFound
    session[:current_room_id] = nil
    redirect_to settings_path, alert: "The room you were in has been deleted."
  end

  def after_sign_in_path_for(resource_or_scope)
    settings_path
  end

  def after_sign_up_path_for(resource_or_scope)
    settings_path
  end

  def after_sign_out_path_for(resource_or_scope)
    settings_path
  end
end
