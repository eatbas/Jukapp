class Room < ActiveRecord::Base
  has_many :queued_videos
  has_many :videos, through: :queued_videos

  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :name, in: 3..30
  validates_format_of :name, with: /[a-z\d\-_\s]+/i, message: "can only be alphanumeric"
end
