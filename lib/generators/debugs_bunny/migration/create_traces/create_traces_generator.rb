# frozen_string_literal: true

require 'rails/generators'
require 'models/debugs_bunny/trace'

module DebugsBunny
  module Migration
    class CreateTracesGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      TEMPLATE_DIR = File.join(TEMPLATES_DIR, 'migrations')
      source_root TEMPLATE_DIR

      def generate_migration
        table = DebugsBunny::Trace.table_descriptor

        instance_eval do
          @table = table
          @active_record_version = ActiveRecord::Migration.current_version
        end

        migrations_dir = File.join('db', 'migrate')
        migration_file = File.join(migrations_dir, "create_#{table.name}.rb")
        migration_template 'create_table.erb', migration_file
      end

      def self.next_migration_number(_migration_dir)
        Time.now.utc.strftime('%Y%m%d%H%M%S')
      end
    end
  end
end
