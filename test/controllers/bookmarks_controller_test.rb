require 'test_helper'

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matt)
  end

  test "should get index" do
    get bookmarks_index_url
    assert_response :success
  end

  test "should get new" do
    get bookmarks_new_url
    assert_redirected_to login_path
    login
    get bookmarks_new_url
    assert_response :success
  end

  test "should upload image" do
    login
    assert_difference('Bookmark.count') do
      post bookmarks_create_url, params: { url: 'mattbettinson.com', description: "my site"}
    end

    assert_redirected_to root_url
  end

  private
  def login
    post login_path, params: { session: { email:    @user.email,
                                          password: 'hello jake' } }
  end
end
