class Room < ActiveRecord::Base
  has_many :queued_videos
  has_many :videos, through: :queued_videos

  validates_uniqueness_of :name
end
