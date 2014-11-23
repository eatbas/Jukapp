class VideoEvent < ActiveRecord::Base
  belongs_to :room
  belongs_to :video

  scope :top_ten_in, -> (room) { where(room_id: room.id).order('play_count DESC').first(10) }
  scope :last_ten_in, -> (room) { where(room_id: room.id).order('played_at DESC').first(10) }

  self.per_page = 50

  def self.play(video, room)
    event = VideoEvent.find_or_create_by(video: video, room: room)
    event.update!(play_count: event.play_count+1, played_at: Time.now)
  end
end
