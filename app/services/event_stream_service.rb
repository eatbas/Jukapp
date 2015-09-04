class EventStreamService
  def self.send_message_to(room, message)
    event = Pubsubstub::Event.new(message.to_json, name: "queue")
    Pubsubstub::RedisPubSub.publish("queue-#{room.id}", event)
  end
end
