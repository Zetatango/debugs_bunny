# frozen_string_literal: true

require 'debugs_bunny'
require 'rails'

module DebugsBunny
  class Railtie < Rails::Railtie
    railtie_name :debugs_bunny

    rake_tasks do
      Dir.glob("#{TASKS_DIR}/**/*.rake").each { |f| load f }
    end
  end
end
