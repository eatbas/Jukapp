class Video < ActiveRecord::Base
  has_many :video_events
  has_many :queued_videos
  has_many :rooms, through: :queued_videos

  def play
    update(played_at: Time.now, play_count: play_count+1)
  end
end
