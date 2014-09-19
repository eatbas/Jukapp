class Video < ActiveRecord::Base

  scope :queued, -> { where(status: "queued").order("queued_at ASC") }

  def queued?
    status == "queued"
  end

  def queue
    update(status: "queued", queued_at: Time.now)
    send_websocket_message
  end

  def play
    raise "Not queued yet" unless queued?
    update(status: "played", played_at: Time.now, play_count: play_count+1)
  end

  def self.pop
    next_video = queued.to_a.reverse.pop
    next_video.try(:play)
    next_video
  end

  private
  def send_websocket_message
    ws = Faye::WebSocket::Client.new("ws://#{Jukapp::Config.app_host}")
    ws.send({operation: "new"}.to_json)
    ws.close
  end
end
