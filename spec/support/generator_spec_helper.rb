# frozen_string_literal: true

module Generators
  def generator_class
    described_class
  end

  def run_generator(*args, **kw_args)
    args = Array(args)
    rails_context do
      g = generator_class.new(args, kw_args, {})
      g.invoke_all
    end
  end

  def read_file(path)
    file = File.open(path)
    contents = file.read
    yield contents
    file.close
  end

  def initializer_file(file_name)
    File.join(RailsContext::TMP_TEST_PROJECT_INITIALIZERS_DIR, file_name)
  end

  def model_file(file_name)
    File.join(RailsContext::TMP_TEST_PROJECT_MODEL_DIR, file_name)
  end

  def migration_file(file_name)
    basename = File.basename(file_name)
    file_path = File.join(RailsContext::TMP_TEST_PROJECT_MIGRATION_DIR, "[0-9]*_#{basename}")
    file = Dir.glob(file_path).first
    file = File.join(RailsContext::TMP_TEST_PROJECT_MIGRATION_DIR, "TIMESTAMP_#{basename}") if file.nil?
    file
  end
end

RSpec.configure do |config|
  config.include Generators, type: :generator
end
