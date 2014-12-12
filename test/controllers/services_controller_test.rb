require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  test "should get preview" do
    get :preview
    assert_response :success
  end

end
