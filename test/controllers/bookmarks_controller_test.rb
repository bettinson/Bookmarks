require 'test_helper'

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bookmarks_index_url
    assert_response :success
  end

  test "should get new" do
    get bookmarks_new_url
    assert_response :success
  end

  test "should get create:post" do
    get bookmarks_create:post_url
    assert_response :success
  end

  test "should get destroy" do
    get bookmarks_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get bookmarks_edit_url
    assert_response :success
  end

end
