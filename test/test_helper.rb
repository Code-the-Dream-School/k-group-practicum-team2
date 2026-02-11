ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  # Load all fixtures
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    

    # Add more helper methods to be used by all tests here...
  
end
