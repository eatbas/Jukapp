require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  test "GET to :join sets the current room id session" do
    room = rooms(:confederation)
    get :join, id: room.id
    assert_equal room.id, session[:current_room_id]
  end

  test "GET to :leave removes the current room id from session" do
    room = rooms(:confederation)
    session[:current_room_id] = room.id

    get :leave
    assert_nil session[:current_room_id]
  end
end
