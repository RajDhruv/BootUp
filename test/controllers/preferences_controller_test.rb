require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get change_panel_color" do
    get preferences_change_panel_color_url
    assert_response :success
  end

  test "should get change_panel_image_visibility" do
    get preferences_change_panel_image_visibility_url
    assert_response :success
  end

end
