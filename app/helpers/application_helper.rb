module ApplicationHelper
  def current_room
    Room.find(session[:current_room_id]) if session[:current_room_id]
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-error"
      when "alert"
        "alert-danger"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def favorite?(youtube_id)
    current_user.favorites.includes(:video).any? { |f| f.video.youtube_id == youtube_id } if youtube_id and user_signed_in?
  end

  def index_with_page(index, page_number)
    page_offset = page_number ? (page_number.to_i - 1) * 50 : 0
    index + 1 + page_offset
  end

  def god_mode?
    # enable god mode for berk, bondtaz and ertavf
    [1, 3, 4].include?(current_user.try(:id))
  end

  def owner?
    current_room && current_room.owner.try(:id) == current_user.try(:id)
  end
end
