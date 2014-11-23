require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "#bootstrap_class_for returns class names based on flash_type" do
    assert_equal "alert-success", bootstrap_class_for("success")
    assert_equal "alert-error", bootstrap_class_for("error")
    assert_equal "alert-danger", bootstrap_class_for("alert")
    assert_equal "alert-info", bootstrap_class_for("notice")
    assert_equal "alert-custom", bootstrap_class_for("custom")
  end

  test "favorite? returns whether or not youtube_id is in favorites" do
    @user = users(:bob)
    sign_in @user
  end

  test "favorite? returns nil when user not logged in" do
    assert_nil? favorite?("some_id")
  end
end
