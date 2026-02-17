# frozen_string_literal: true

require 'bundler/setup'
require 'factory_bot'
require 'rails/all'
require 'porky_lib'

require 'debugs_bunny'
require 'factories/debug_trace'

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
    add_group 'lib', %w[lib]
    add_group 'models', %w[lib/debugs_bunny/models]
    add_group 'spec', %w[spec]
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  PorkyLib::Config.configure(aws_region: 'us-east-1',
                             aws_key_id: 'key_id',
                             aws_key_secret: 'key_secret',
                             aws_client_mock: true)
  PorkyLib::Config.initialize_aws

  DebugsBunny.configuration.encryption_cmk_key_id = 'test_cmk_id'

  RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

  config.before do
    logger = Logger.new($stdout)
    allow(Rails).to receive(:logger).and_return(logger)
    allow(Rails.cache).to receive(:write)
    allow(Rails.cache).to receive(:read)
  end
end
