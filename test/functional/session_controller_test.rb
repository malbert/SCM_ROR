require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get user_session" do
    get :user_session
    assert_response :success
  end

end
