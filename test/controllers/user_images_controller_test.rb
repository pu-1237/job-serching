require "test_helper"

class UserImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_images_index_url
    assert_response :success
  end

  test "should get new" do
    get user_images_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_images_edit_url
    assert_response :success
  end
end
