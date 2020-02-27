# frozen_string_literal: true

require 'rails/generators'

module DebugsBunny
  class TraceGenerator < Rails::Generators::NamedBase
    TEMPLATE_DIR = File.join(TEMPLATES_DIR, 'model')
    source_root TEMPLATE_DIR

    def generate_model
      models_dir = File.join('app', 'models')
      model_file = File.join(models_dir, "#{file_name}.rb")

      template 'trace_subclass.erb', model_file
    end
  end
end
