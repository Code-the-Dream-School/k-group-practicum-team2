require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = false

  test "should get home" do
    get pages_home_url
    assert_response :success
  end
end
