# frozen_string_literal: true

require 'rake'

module Tasks
  def run_task
    rails_context do
      load file
      Rake::Task[task].invoke
    end
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
