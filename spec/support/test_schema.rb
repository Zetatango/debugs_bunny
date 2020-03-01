# frozen_string_literal: true

require 'models/debugs_bunny/trace'
require 'models/debugs_bunny/encryption_key'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table 'debug_traces', force: :cascade do |t|
    DebugsBunny::Trace.table_descriptor.column_descriptors.each do |column|
      t.send(column.type, column.name, column.option_list.to_h)
    end
    t.timestamps
    DebugsBunny::Trace.table_descriptor.index_descriptors.each do |index|
      t.send(:index, index.columns, index.option_list.to_h)
    end
  end

  create_table 'encryption_keys', force: :cascade do |t|
    DebugsBunny::EncryptionKey.table_descriptor.column_descriptors.each do |column|
      t.send(column.type, column.name, column.option_list.to_h)
    end
    t.timestamps
    DebugsBunny::EncryptionKey.table_descriptor.index_descriptors.each do |index|
      t.send(:index, index.columns, index.option_list.to_h)
    end
  end
end
