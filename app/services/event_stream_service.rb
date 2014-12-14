class EventStreamService
  def self.send_message_to(room, message)
    Pusher.url = ENV['PUSHER_URL']
    Pusher["queue-#{room.id}"].trigger(message, {})
  end
end
