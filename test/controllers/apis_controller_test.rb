require 'test_helper'

class ApisControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get apis_create_url
    assert_response :success
  end

  test "should get destroy" do
    get apis_destroy_url
    assert_response :success
  end

  test "should get new" do
    get apis_new_url
    assert_response :success
  end

  test "should get update" do
    get apis_update_url
    assert_response :success
  end

end
