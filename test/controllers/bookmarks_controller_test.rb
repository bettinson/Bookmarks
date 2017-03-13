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

  test "should create bookmark" do
    login
    assert_difference('Bookmark.count') do
      post bookmarks_create_url, params: { url: 'mattbettinson.com', description: "my site"}
    end
   assert_redirected_to root_url
  end

  test "shouldn't upload invalid image" do
    login
    assert_no_difference('Bookmark.count') do
      post bookmarks_create_url, params: { url: '', description: ''}
    end
   assert_redirected_to bookmarks_new_url
  end

  test "should create bookmark with tags" do
    login
    tag_names = ['programming', 'me']
    url = "github.bettinson.com"
    assert_difference('Bookmark.count') do
      post bookmarks_create_url, params: { url: url, description: "my site, with tags", tags: "programming me"}
    end
    bookmark = Bookmark.find_by(url: url)
    
    bookmark.tags.each_with_index do |tag, index|
      assert_equal tag.name, tag_names[index]
    end
  end

  private
  def login
    post login_path, params: { session: { email:    @user.email,
                                          password: 'hello jake' } }
  end
end
