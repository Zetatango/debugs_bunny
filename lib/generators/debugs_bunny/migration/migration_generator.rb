# frozen_string_literal: true

require 'rails/generators'
require 'debugs_bunny/internal/schema/table_descriptor'

module DebugsBunny
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    class_option :table_name, type: :string, required: true

    source_root File.expand_path('templates', __dir__)

    def generate_migration
      table_name = options['table_name'].to_s.underscore.pluralize
      table = DebugsBunny::Internal::Schema::TableDescriptor.new(
        table_name,
        DebugsBunny::Internal::Schema::ColumnDescriptor.new(:guid, :string, null: false),
        DebugsBunny::Internal::Schema::ColumnDescriptor.new(:dump, :string, null: false)
      )

      instance_eval do
        @table = table
        @active_record_version = ActiveRecord::Migration.current_version
      end

      migrations_dir = File.join('db', 'migrate')
      migration_file = File.join(migrations_dir, "create_#{table_name}.rb")
      migration_template 'migration_template.erb', migration_file
    end

    def self.next_migration_number(_migration_dir)
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    end
  end
end
