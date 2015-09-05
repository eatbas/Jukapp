class Room < ActiveRecord::Base
  has_many :videos
  belongs_to :owner, class_name: "User"

  validates_uniqueness_of :name
  validates_presence_of :name, :owner
  validates_length_of :name, in: 3..30
  validates_format_of :name, with: /[a-z\d\-_\s]+/i, message: "can only be alphanumeric"
end
