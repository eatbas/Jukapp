class Room < ActiveRecord::Base
  has_many :video_events
  has_many :queued_videos
  has_many :videos, through: :queued_videos
  has_many :recommended_videos
  belongs_to :owner, class_name: "User"

  validates_uniqueness_of :name
  validates_presence_of :name, :owner
  validates_length_of :name, in: 3..30
  validates_format_of :name, with: /[a-z\d\-_\s]+/i, message: "can only be alphanumeric"

  def has_recommendations?
    recommended_videos.present?
  end
end
