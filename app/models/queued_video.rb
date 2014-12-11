class QueuedVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :room

  scope :queue_in, -> (room) { where(room_id: room).includes(:video).order(:created_at) }

  def self.queue(video, room)
    create(video_id: video.id, room_id: room.id)
    EventStreamService.send_message_to(room, "new")
  end

  def self.videos_in(room)
    self.queue_in(room).map(&:video)
  end

  def self.next_in(room)
    queue_in(room).first
  end

  def play_and_destroy
    destroy.video.play_in(room)
  end
end
