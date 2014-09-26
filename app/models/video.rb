class Video < ActiveRecord::Base
  has_many :video_events
  has_many :queued_videos
  has_many :rooms, through: :queued_videos

  def play_in(room)
    VideoEvent.play(self, room)
  end
end
