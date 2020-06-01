# frozen_string_literal: true

module RailsContext
  TEST_PROJECT_NAME = 'rails_test_app'
  SRC_TEST_PROJECT_ROOT_DIR = File.join(DebugsBunny::SPEC_DIR, TEST_PROJECT_NAME).freeze
  TMP_TEST_PROJECT_ROOT_DIR = File.join(DebugsBunny::TMP_DIR, TEST_PROJECT_NAME).freeze

  TMP_TEST_PROJECT_APP_DIR = File.join(TMP_TEST_PROJECT_ROOT_DIR, 'app').freeze
  TMP_TEST_PROJECT_MODEL_DIR = File.join(TMP_TEST_PROJECT_APP_DIR, 'models').freeze
  TMP_TEST_PROJECT_MIGRATION_DIR = File.join(TMP_TEST_PROJECT_ROOT_DIR, File.join('db', 'migrate'))
  TMP_TEST_PROJECT_CONFIG_DIR = File.join(TMP_TEST_PROJECT_ROOT_DIR, 'config').freeze
  TMP_TEST_PROJECT_INITIALIZERS_DIR = File.join(TMP_TEST_PROJECT_CONFIG_DIR, 'initializers').freeze

  def self.included(klass)
    klass.class_exec do
      before do
        clone_test_project
      end

      after do
        remove_test_project
      end
    end
  end

  def rails_context
    FileUtils.cd(TMP_TEST_PROJECT_ROOT_DIR) do
      yield
    end
  end

  def remove_test_project
    FileUtils.remove_dir TMP_TEST_PROJECT_ROOT_DIR if File.directory?(TMP_TEST_PROJECT_ROOT_DIR)
  end

  def clone_test_project
    remove_test_project
    FileUtils.mkdir_p(DebugsBunny::TMP_DIR) unless File.directory?(DebugsBunny::TMP_DIR)
    FileUtils.cp_r SRC_TEST_PROJECT_ROOT_DIR, DebugsBunny::TMP_DIR
  end
end

RSpec.configure do |config|
  config.include RailsContext
end
