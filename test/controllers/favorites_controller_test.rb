require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    sign_in @user
  end

  test "POST to :create creates a new favorite video" do
    video = videos(:funny_video)
    Favorite.find_by(video_id: video.id, user: @user).try(:destroy)
    assert_difference "Favorite.count" do
      post :create, video_id: video.id
    end
    assert_response :success
  end

  test "DELETE to :destroy removes video from favorites" do
    favorite = favorites(:bobs_fav_video)
    assert_difference "Favorite.count", -1 do
      delete :destroy, video_id: favorite.video_id
    end
    assert_response :success
  end
end
