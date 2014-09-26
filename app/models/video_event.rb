class VideoEvent < ActiveRecord::Base
  belongs_to :room
  belongs_to :video

  def self.play(video, room)
    event = VideoEvent.find_or_create_by(video: video, room: room)
    event.update!(play_count: event.play_count+1, played_at: Time.now)
  end
end
