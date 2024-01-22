require "test_helper"

class DogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dogs_new_url
    assert_response :success
  end

  test "should get create" do
    get dogs_create_url
    assert_response :success
  end
end
