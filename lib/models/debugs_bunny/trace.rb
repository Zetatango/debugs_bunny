# frozen_string_literal: true

require 'debugs_bunny/config'
require 'debugs_bunny/internal/schema/column_descriptor'

module DebugsBunny
  class Trace < DebugsBunny::ApplicationRecord
    include CanGenerate
    include HasEncryptedAttributes

    self.abstract_class = true

    has_guid 'trc'

    def generate_partition_guid
      self.partition_guid = DebugsBunny.configuration.encryption_partition_guid
    end

    define_encrypted_attributes do
      attr_encrypted :dump
    end

    define_table do |t|
      t.define_column :guid, :string, null: false
      t.define_column :encrypted_dump, :string
      t.define_column :encrypted_dump_iv, :string
      t.define_column :partition_guid, :string, null: false
      t.define_column :encryption_epoch, :string, null: false
      t.define_index :unique_guid, [:guid], unique: true
    end
  end
end
