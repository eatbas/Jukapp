class Video < ActiveRecord::Base

  has_many :queued_videos
  has_many :rooms, through: :queued_videos
  scope :queued, -> { where(status: "queued").order("queued_at ASC") }

  def queued?
    status == "queued"
  end

  def queue
    update(status: "queued", queued_at: Time.now)
    ESHQ.send( channel: "video-queue", data: {operation: "new"}.to_json )
  end

  def queue_in(room)
    queued = queued_videos.new
    queued.room = room
    queued.save

    ESHQ.send( channel: "queue-#{room.id}", data: {operation: "new"}.to_json )
  end

  def play_in(room)
    raise "Not queued in #{room.name}" unless queued = queued_videos.find_by(room_id: room.id)
    queued.destroy
    update(played_at: Time.now, play_count: play_count+1)
  end

  def play
    update(played_at: Time.now, play_count: play_count+1)
  end

  def self.pop
    next_video = queued.to_a.reverse.pop
    next_video.try(:play)
    next_video
  end
end
