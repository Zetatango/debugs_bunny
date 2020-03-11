# frozen_string_literal: true

module Generators
  ROOT_DIR = File.expand_path('../..', __dir__)
  SPEC_DIR = File.join(ROOT_DIR, 'spec')
  TMP_DIR = File.join(ROOT_DIR, 'tmp')

  TEST_PROJECT_NAME = 'rails_test_app'

  SRC_TEST_PROJECT_ROOT_DIR = File.join(SPEC_DIR, TEST_PROJECT_NAME).freeze

  TMP_TEST_PROJECT_ROOT_DIR = File.join(TMP_DIR, TEST_PROJECT_NAME).freeze
  TMP_TEST_PROJECT_APP_DIR = File.join(TMP_TEST_PROJECT_ROOT_DIR, 'app').freeze
  TMP_TEST_PROJECT_MODEL_DIR = File.join(TMP_TEST_PROJECT_APP_DIR, 'models').freeze
  TMP_TEST_PROJECT_MIGRATION_DIR = File.join(TMP_TEST_PROJECT_ROOT_DIR, File.join('db', 'migrate'))
  TMP_TEST_PROJECT_CONFIG_DIR = File.join(TMP_TEST_PROJECT_ROOT_DIR, 'config').freeze
  TMP_TEST_PROJECT_INITIALIZERS_DIR = File.join(TMP_TEST_PROJECT_CONFIG_DIR, 'initializers').freeze

  def generator_class
    described_class
  end

  def run_generator(*args, **kw_args)
    args = Array(args)
    FileUtils.cd(TMP_TEST_PROJECT_ROOT_DIR) do
      g = generator_class.new(args, kw_args, {})
      g.invoke_all
    end
  end

  def remove_test_project
    FileUtils.remove_dir TMP_TEST_PROJECT_ROOT_DIR if File.directory?(TMP_TEST_PROJECT_ROOT_DIR)
  end

  def clone_test_project
    remove_test_project
    FileUtils.mkdir_p(TMP_DIR) unless File.directory?(TMP_DIR)
    FileUtils.cp_r SRC_TEST_PROJECT_ROOT_DIR, TMP_DIR
  end

  def read_file(path)
    file = File.open(path)
    contents = file.read
    yield contents
    file.close
  end

  def initializer_file(file_name)
    File.join(TMP_TEST_PROJECT_INITIALIZERS_DIR, file_name)
  end

  def model_file(file_name)
    File.join(TMP_TEST_PROJECT_MODEL_DIR, file_name)
  end

  def migration_file(file_name)
    basename = File.basename(file_name)
    file_path = File.join(TMP_TEST_PROJECT_MIGRATION_DIR, "[0-9]*_#{basename}")
    file = Dir.glob(file_path).first
    file = File.join(TMP_TEST_PROJECT_MIGRATION_DIR, "TIMESTAMP_#{basename}") if file.nil?
    file
  end
end

RSpec.configure do |config|
  config.include Generators, type: :generator
end
