require 'test_helper'

class ReactionTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
    @bookmark = Bookmark.new(url: 'mattbettinson.com', description: "my site", user_id: @user.id)
  end

  test "reaction should be invalid" do
    @reaction = Reaction.new(liked: true)
    assert_not @reaction.valid?
    @reaction = Reaction.new(liked: true, bookmark_id: @bookmark.id)
    assert_not @reaction.valid?
    @reaction = Reaction.new(liked: true, bookmark_id: @bookmark.id, user_id: @user.id)
    @bookmark.reactions << @reaction
    @user.reactions << @reaction
    assert @reaction.valid?
  end

  test "should add a reaction to a bookmark" do
    @reaction = Reaction.new(liked: true, bookmark_id: @bookmark.id, user_id: @user.id)
    @bookmark.reactions << @reaction
    @user.reactions << @reaction
    assert @bookmark.valid?
    assert @reaction.valid?
    assert @bookmark.reactions.include?(@reaction)
    assert_equal @reaction.bookmark, @bookmark
  end
end
