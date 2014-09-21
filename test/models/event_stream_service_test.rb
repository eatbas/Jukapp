require 'test_helper'

class EventStreamServiceTest < ActiveSupport::TestCase
  test "#send_message_to sends given message to given room" do
    room = rooms(:confederation)
    ESHQ.expects(:send).with(channel: "queue-#{room.id}", data: {operation: "new"}.to_json )
    EventStreamService.send_message_to(room, {operation: "new"})
  end
end
