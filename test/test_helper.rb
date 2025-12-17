# frozen_string_literal: true

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "dummy/config/environment"
require "rails/test_help"
require "capybara/minitest"
require "view_component/test_helpers"
require "view_component/test_case"
require "active_record"

# Establish database connection
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)


class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here
end

class ViewComponent::TestCase
  include ViewComponent::TestHelpers
  include Capybara::Minitest::Assertions

  def page
    Capybara::Node::Simple.new(rendered_content)
  end
end
