class YoutubeVideo < ActiveRecord::Base
  has_many :videos
  validates_presence_of :youtube_id
  validates_uniqueness_of :youtube_id

  before_create :initialize_from_youtube

  def initialize_from_youtube
    youtube_video = Yt::Video.new(id: youtube_id)
    self.title = youtube_video.title
    self.description = youtube_video.description
    self.length = youtube_video.duration
  end
end
