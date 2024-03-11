require 'capybara/rspec'
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    browser_options: { 'no-sandbox': nil },
    inspector: true,
    url:  'http://chrome:3333',
    base_url: 'http://front:2000'
  )
end

Capybara.javascript_driver = :cuprite

include Capybara::DSL

RSpec.configure do |config|
    
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
