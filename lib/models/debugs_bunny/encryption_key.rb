# frozen_string_literal: true

require 'daffy_lib'

require_relative 'concerns/can_generate'

module DaffyLib
  class EncryptionKey
    after_rollback :rollback_callback

    def rollback_callback
      self.class.create(attributes)
    end
  end
end

module DebugsBunny
  class EncryptionKey < ::DaffyLib::EncryptionKey
    include CanGenerate

    table_descriptor.name = 'encryption_keys'

    define_table do |t|
      t.define_column :encrypted_data_encryption_key, :string, null: false
      t.define_column :guid, :string, null: false
      t.define_column :key_epoch, :datetime, null: false
      t.define_column :partition_guid, :string, null: false
      t.define_column :version, :string, null: false
      t.define_index :index_encryption_keys_on_guid, %w[guid], unique: true
      t.define_index :index_encryption_keys, %w[partition_guid key_epoch], unique: true
    end
  end
end
