# frozen_string_literal: true

require 'active_record'
require 'rails/generators'
require 'models/debugs_bunny/encryption_key'

module DebugsBunny
  module Migration
    class CreateEncryptionKeysGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      TEMPLATE_DIR = File.join(TEMPLATES_DIR, 'migrations')
      source_root TEMPLATE_DIR

      def generate_migration
        table = DebugsBunny::EncryptionKey.table_descriptor

        if ActiveRecord::Base.connection.table_exists?(table.name)
          puts "#{self.class.name}: The table #{table.name} already exists. A new migration will not be generated."
          return
        end

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
