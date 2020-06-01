# frozen_string_literal: true

require 'generators/debugs_bunny/migration/create_encryption_keys/create_encryption_keys_generator'

RSpec.describe DebugsBunny::Migration::CreateEncryptionKeysGenerator, type: :generator do
  let(:table_name) { 'encryption_keys' }
  let(:file_name) { "create_#{table_name}.rb" }

  before do
    allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)
  end

  it 'creates a migration file' do
    run_generator table_name: table_name
    path = migration_file(file_name)
    expect(File).to exist(path)
  end

  it 'does not create a migration file if the table already exists' do
    allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(true)
    run_generator table_name: table_name
    path = migration_file(file_name)
    expect(File).not_to exist(path)
  end

  it 'creates a migration with the given table name' do
    run_generator table_name: table_name
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "create_table :#{table_name}"
    end
  end

  it 'creates a migration that inherits from the current ActiveRecord::Migration' do
    run_generator table_name: table_name
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "< ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]"
    end
  end

  it 'creates a migration with the expected guid column' do
    run_generator table_name: table_name
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include 't.string :guid, null: false'
    end
  end

  it 'creates a migration with the expected timestamp columns' do
    run_generator table_name: table_name
    path = migration_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include 't.timestamps'
    end
  end
end
