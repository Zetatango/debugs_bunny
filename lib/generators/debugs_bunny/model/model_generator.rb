# frozen_string_literal: true

require 'rails/generators'

module DebugsBunny
  class ModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def generate_model
      models_dir = File.join('app', 'models')
      model_file = File.join(models_dir, "#{file_name}.rb")

      template 'model_template.erb', model_file
    end
  end
end
