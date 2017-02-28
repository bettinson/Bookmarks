require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Matt Bettinson", email: "mattbettinson@me.com", password: "password", password_confirmation: "password")
  end

  test "User should be valid" do
    assert @user.valid?
  end
end