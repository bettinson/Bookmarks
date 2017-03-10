ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def login
    @user_params = {name: "Matt Bettinson", email: "mattbettinson@me.com", password: "hello jake", password_confirmation: "hello jake"}
    post login_path, params: @user_params
  end

  # Add more helper methods to be used by all tests here...
end

