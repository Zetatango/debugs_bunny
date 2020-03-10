# frozen_string_literal: true

require 'active_record'
require 'rails/generators'

module DebugsBunny
  class ConfigGenerator < Rails::Generators::Base
    TEMPLATE_DIR = File.join(TEMPLATES_DIR, 'initializers')
    source_root TEMPLATE_DIR

    def generate_initializer
      initializers_dir = File.join('config', 'initializers')
      initializer_file = File.join(initializers_dir, 'debugs_bunny.rb')
      template 'debugs_bunny.erb', initializer_file
    end
  end
end
