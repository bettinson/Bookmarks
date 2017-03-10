require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
  end

  test "User should be valid" do
    assert @user.valid?
  end
end
