# ENV['RAILS_ENV'] ||= 'test'
# require_relative "../config/environment"
# require "rails/test_help"

# class ActiveSupport::TestCase
#   # Run tests in parallel with specified workers
#   parallelize(workers: :number_of_processors)

#   # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#   fixtures :all

#   # Add more helper methods to be used by all tests here...
# end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all


  #custom helper methods by melnee from tutorial:

  #helper method sign_in to sign in as admin in the categories controller test.rb file
  #you can reference user.email, but password has to actually be typed out, otherwise you'll get the hash, and that's not the password
  def sign_in_as(user)
    #go to the post login path and insert the session params to login
    post login_path, params: { session: {email: user.email, password: "password" }}
  end
end