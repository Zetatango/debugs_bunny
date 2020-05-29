# frozen_string_literal: true

require 'debugs_bunny'
require 'rails'

module DebugsBunny
  class Railtie < Rails::Railtie
    railtie_name :debugs_bunny

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
