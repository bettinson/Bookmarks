require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
  end

  test "should add a tag to a bookmark" do
    @bookmark = Bookmark.new(url: 'mattbettinson.com', description: "my site", user_id: @user.id)
    assert @bookmark.valid?
    @tag = Tag.new(name: "programming")
    @tag.bookmarks << @bookmark
    @bookmark.tags << @tag
    assert @bookmark.tags.include?(@tag)
  end

  private
end
