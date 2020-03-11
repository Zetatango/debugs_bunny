# frozen_string_literal: true

require 'rails/generators'

module DebugsBunny
  class InstallGenerator < Rails::Generators::Base
    def install
      model_name = 'DebugTrace'
      generate "debugs_bunny:trace #{model_name}"
      generate "debugs_bunny:migration:create_traces --table_name #{model_name}"
      generate 'debugs_bunny:migration:create_encryption_keys'
      generate 'debugs_bunny:config'
    end
  end
end
