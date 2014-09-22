module ApplicationHelper
  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end

  def event_stream_params
    "'#{current_room.id}', '#{queue_socket_path}', '#{session[:_csrf_token]}'".html_safe
  end
end
