# frozen_string_literal: true

require 'spec_helper'

require 'generators/debugs_bunny/install/install_generator'

RSpec.describe DebugsBunny::InstallGenerator, type: :generator do
  let(:debug_trace_model_name) { 'DebugTrace' }
  let(:debug_trace_model_file_name) { "#{debug_trace_model_name.underscore}.rb" }
  let(:debug_trace_migration_file_name) { "create_#{debug_trace_model_name.underscore.pluralize}.rb" }
  let(:encryption_key_migration_file_name) { 'create_encryption_keys.rb' }

  before do
    clone_test_project
    run_generator
  end

  after do
    remove_test_project
  end

  it 'creates the DebugTrace model file' do
    path = model_file(debug_trace_model_file_name)
    expect(File).to exist(path)
  end

  it 'creates the DebugTrace migration file' do
    path = migration_file(debug_trace_migration_file_name)
    expect(File).to exist(path)
  end

  it 'creates the EncryptionKey migration file' do
    path = migration_file(encryption_key_migration_file_name)
    expect(File).to exist(path)
  end

  it 'creates the configuration initializer file' do
    path = initializer_file('debugs_bunny.rb')
    expect(File).to exist(path)
  end
end
