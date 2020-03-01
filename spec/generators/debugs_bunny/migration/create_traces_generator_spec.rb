# frozen_string_literal: true

require 'spec_helper'

require 'generators/debugs_bunny/migration/create_traces/create_traces_generator'

RSpec.describe DebugsBunny::Migration::CreateTracesGenerator, type: :generator do
  let(:table_name) { 'debug_traces' }
  let(:file_name) { "create_#{table_name}.rb" }

  before do
    clone_test_project
    run_generator table_name: table_name
  end

  after do
    remove_test_project
  end

  it 'creates a migration file' do
    path = migration_file(file_name)
    expect(File).to exist(path)
  end

  it 'creates a migration with the given table name' do
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "create_table :#{table_name}"
    end
  end

  it 'creates a migration that inherits from the current ActiveRecord::Migration' do
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "< ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]"
    end
  end

  it 'creates a migration with the expected guid column' do
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include 't.string :guid, null: false'
    end
  end

  it 'creates a migration with the expected encrypted dump columns' do
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include 't.string :encrypted_dump'
      expect(contents).to include 't.string :encrypted_dump_iv'
    end
  end

  it 'creates a migration with the expected timestamp columns' do
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include 't.timestamps'
    end
  end
end
