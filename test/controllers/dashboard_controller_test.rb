require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_dashboard_url
    assert_response :success
  end  
end
