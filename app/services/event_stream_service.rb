class EventStreamService
  def self.send_message_to(room, message)
    ESHQ.send(channel: "queue-#{room.id}", data: message.to_json)
  end
end
