require 'test_helper'

class VideoEventsControllerTest < ActionController::TestCase
  test "should get index" do
    join_room rooms(:confederation)

    get :index
    assert_response :success
  end

end
