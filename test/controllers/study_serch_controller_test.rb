require 'test_helper'

class StudySerchControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get study_serch_home_url
    assert_response :success
  end

end
