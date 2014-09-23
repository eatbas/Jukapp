module ApplicationHelper
  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end

  def event_stream_params
    "'#{current_room.id}', '#{queue_socket_path}', '#{session[:_csrf_token]}'".html_safe
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-error"
      when "alert"
        "alert-block"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end
end
