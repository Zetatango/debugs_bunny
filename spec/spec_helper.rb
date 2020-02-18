# frozen_string_literal: true

require 'bundler/setup'
require 'factory_bot'

require 'debugs_bunny'
require 'support/model_spec_helper'

if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'
  require 'codecov'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::Codecov,
      SimpleCov::Formatter::HTMLFormatter
    ]
  )

  SimpleCov.start do
    add_group 'LIB', %w[lib spec]
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Models, type: :model
end
