require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
  end

  test "should create tag and add to bookmark" do
    @bookmark = Bookmark.new(url: 'mattbettinson.com', description: "my site", user_id: @user.id)
    assert @bookmark.valid?
    @tag = Tag.new(name: "programming")
    @tag.bookmarks << @bookmark
    assert @tag.bookmarks.include?(@bookmark)
  end
end
