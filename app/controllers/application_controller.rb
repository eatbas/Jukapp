class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_room_exists

  after_action :flash_to_headers

  def ensure_in_room
    unless current_room
      redirect_to settings_path, notice: "First you have to join a room."
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

  def render_video_rows(videos)
    if videos.first.class == VideoEvent
      render partial: "shared/stats_table", locals: { stats: videos }
    else
      render partial: "shared/videos_table", locals: { videos: videos }
    end
  end

  private

  def flash_to_headers
    return unless request.xhr?

    flash_message, flash_type = flash_message_and_type

    if flash_message.present?
      response.headers['X-Toast'] = flash_message
      response.headers["X-Toast-Type"] = flash_type

      flash.discard # don't want the flash to appear when you reload page
    end
  end

  def flash_message_and_type
    [:error, :warning, :notice].map do |type|
      [ flash[type], type.to_s ] unless flash[type].blank?
    end.compact.first
  end
end
