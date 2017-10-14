require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(color: true)

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  def sign_up_as(args)
    get new_user_registration_path
    post user_registration_path, params: {
      user: {
        email: args[:email],
        password: 'foobar',
        password_confirmation: 'foobar'
      }
    }
  end

  def log_in_as(user, password: 'foobar')
    get new_user_session_path
    post user_session_path, params: {
      user: {
        email: user.email,
        password: password
      }
    }
  end

  def log_out
    delete destroy_user_session_path
  end
end
