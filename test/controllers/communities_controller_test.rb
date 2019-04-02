require 'test_helper'

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get communities_index_url
    assert_response :success
  end

end
