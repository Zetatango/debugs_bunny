# frozen_string_literal: true

require_relative 'application_record'
require_relative 'concerns/can_generate'
require_relative 'concerns/has_encrypted_attributes'
require 'debugs_bunny/config'
require 'debugs_bunny/internal/schema/column_descriptor'

module DebugsBunny
  class Trace < DebugsBunny::ApplicationRecord
    include CanGenerate
    include HasEncryptedAttributes

    self.abstract_class = true

    has_guid 'trc'

    scope :created_before, ->(time) { where('created_at <= ?', time) }
    scope :created_after, ->(time) { where('created_at >= ?', time) }
    scope :created_between, ->(time_range) { where(created_at: time_range) }

    scope :older_than, lambda { |age|
      time = Time.now.utc - age
      created_before(time)
    }

    scope :newer_than, lambda { |age|
      time = Time.now.utc - age
      created_after(time)
    }

    after_rollback :rollback_callback

    def rollback_callback
      self.class.create({ **attributes, dump: dump })
    end

    def generate_partition_guid
      self.partition_guid = DebugsBunny.configuration.encryption_partition_guid
    end

    define_encrypted_attributes do
      attr_encrypted :dump
    end

    define_table do |t|
      t.name = 'debug_traces'
      t.define_column :guid, :string, null: false
      t.define_column :encrypted_dump, :string
      t.define_column :encrypted_dump_iv, :string
      t.define_column :partition_guid, :string, null: false
      t.define_column :encryption_epoch, :string, null: false
      t.define_index :unique_guid, [:guid], unique: true
    end

    self.table_name = @table_descriptor.name
  end
end
