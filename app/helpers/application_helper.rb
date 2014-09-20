module ApplicationHelper
  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end
end
