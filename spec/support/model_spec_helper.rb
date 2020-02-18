# frozen_string_literal: true

module Models
  # Setup temporary database for testing
  ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
  load File.dirname(__FILE__) + '/test_schema.rb'
end
