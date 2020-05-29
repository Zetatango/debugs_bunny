# frozen_string_literal: true

require 'database_cleaner'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
end
