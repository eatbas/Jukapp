class EventStreamService
  def self.send_message_to(room, message)
    Pusher.url = "http://#{ENV['PUSHER_KEY']}:#{ENV['PUSHER_SECRET']}@api.pusherapp.com/apps/#{ENV['PUSHER_ID']}"
    Pusher["queue-#{room.id}"].trigger(message, {})
  end
end
