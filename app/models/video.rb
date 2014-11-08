class Video < ActiveRecord::Base
  has_many :video_events
  has_many :queued_videos
  has_many :rooms, through: :queued_videos

  validates_presence_of :youtube_id

  def self.from_youtube(youtube_id, title: "Unknown")
    Video.create_with(title: title).find_or_create_by(youtube_id: youtube_id)
  end

  def self.from_reddit(subreddit)
    return unless subreddit.present?

    video = RedditService.get_video_from(subreddit)
    Video.create_with(title: video.title).find_or_create_by(youtube_id: video.youtube_id)
  end

  def play_in(room)
    VideoEvent.play(self, room)
    self
  end
end
