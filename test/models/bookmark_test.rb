require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  def setup
    @user_params = {name: "Matt Bettinson", email: "mattbettinson@me.com", password: "hello jake", password_confirmation: "hello jake"}
  end

  test "Login and post a bookmark and logout" do
    post login_path, params: @user_params
  end
end
