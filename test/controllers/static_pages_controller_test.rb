require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get ratings_guide" do
    get :ratings_guide
    assert_response :success
  end

end
