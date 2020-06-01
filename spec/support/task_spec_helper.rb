# frozen_string_literal: true

require 'rake'

module Tasks
  def run_task
    Rake::Task[task].execute
  end
end

module Models
  # Setup temporary database for testing
  ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
  load File.dirname(__FILE__) + '/test_schema.rb'
end

RSpec.configure do |config|
  config.include Tasks, type: :task
  config.include Models, type: :task
end
