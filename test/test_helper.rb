require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(color: true)

# :nodoc:
class ActiveSupport::TestCase
  fixtures :all
end
