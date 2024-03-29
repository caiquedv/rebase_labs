require 'capybara/rspec'
require "capybara/cuprite"
require 'debug'
require 'rspec'
require_relative '../server.rb'

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    browser_options: { 'no-sandbox': nil },
    inspector: true
  )
end

Capybara.javascript_driver = :cuprite
Capybara.app = Sinatra::Application
Capybara.app_host = 'http://front:2000'

include Capybara::DSL

RSpec.configure do |config|
  config.before(:each) do
    visit '/set-test-mode'
  end

  config.after(:each) do
    visit '/reset-test-mode'
  end
    
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
