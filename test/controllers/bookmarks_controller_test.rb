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

    url = "github.bettinson.com"
    tag_names = ['programming', 'me']
    assert_difference('Bookmark.count') do
      post bookmarks_create_url, params: { url: url, description: "my site, with tags", tags: "programming me"}
    end

    bookmark = Bookmark.find_by(url: url)
    tag = Tag.find_by(name: "programming")
    assert tag.bookmarks.include? (bookmark)
    assert bookmark.tags.include? (tag)
  end

  test "should create bookmark with reaction" do
    login
    url = "github.bettinson.com"
    post bookmarks_create_url, params: { url: url, description: "my site, with tags", tags: "programming me"}
    bookmark = Bookmark.find_by(url: url)

    assert_difference('Reaction.count') do
      post bookmarks_react_url, params: { id: bookmark.id, liked: 1 }
    end

    reaction = Reaction.last
    assert_equal reaction.bookmark, bookmark
    assert_equal reaction.liked, 1
  end

  test "should create bookmark with reaction and nullify after 'like' post" do
    login
    url = "github.bettinson.com"
    post bookmarks_create_url, params: { url: url, description: "my site, with tags", tags: "programming me"}
    bookmark = Bookmark.find_by(url: url)

    assert_difference('Reaction.count') do
      post bookmarks_react_url, params: {id: bookmark.id, liked: 1 }
    end

    reaction = Reaction.last

    same_reaction = Reaction.last
    assert_equal reaction.user, same_reaction.user
    assert_equal reaction.bookmark, bookmark
  end


  test "should create bookmark with reaction and not be able to vote more than once" do
    login
    url = "github.bettinson.com"
    post bookmarks_create_url, params: { url: url, description: "my site, with tags", tags: "programming me"}
    bookmark = Bookmark.find_by(url: url)

    assert_difference('Reaction.count') do
      post bookmarks_react_url, params: { id: bookmark.id, liked: 1 }
    end

    reaction = Reaction.last
    assert_equal reaction.bookmark, bookmark
    assert_equal reaction.liked, 1

    post bookmarks_react_url, params: { id: bookmark.id, liked: 1 }
    assert_equal reaction.liked, 1
  end

  test "should create bookmark with reaction and not be able to vote more than once and have score" do
    login
    url = "github.bettinson.com"
    post bookmarks_create_url, params: { url: url, description: "my site, with tags", tags: "programming me"}
    bookmark = Bookmark.find_by(url: url)

    assert_difference('Reaction.count') do
      post bookmarks_react_url, params: { id: bookmark.id, liked: 1 }
    end

    reaction = Reaction.last
    assert_equal reaction.bookmark, bookmark
    assert_equal reaction.liked, 1
    bookmark.reload
    assert_equal bookmark.score, 1

    post bookmarks_react_url, params: { id: bookmark.id, liked: 1 }
    assert_equal bookmark.score, 1
    bookmark.reload
    assert_equal reaction.liked, 1

    post bookmarks_react_url, params: { id: bookmark.id, liked: -1 }
    bookmark.reload
    assert_equal bookmark.score, 0
    reaction.reload
    assert_equal reaction.liked, 0
  end

  private
  def login
    post login_path, params: { session: { email:    @user.email,
                                          password: 'hello jake' } }
  end
end
