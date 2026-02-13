# frozen_string_literal: true

require 'models/debugs_bunny/trace'
require 'models/debugs_bunny/encryption_key'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table 'debug_traces', force: :cascade do |t|
    DebugsBunny::Trace.table_descriptor.column_descriptors.each do |column|
      options = column.option_list.to_h
      if options.empty?
        t.send(column.type, column.name)
      else
        t.send(column.type, column.name, **options)
      end
    end
    t.timestamps
    DebugsBunny::Trace.table_descriptor.index_descriptors.each do |index|
      options = index.option_list.to_h
      if options.empty?
        t.send(:index, index.columns)
      else
        t.send(:index, index.columns, **options)
      end
    end
  end

  create_table 'encryption_keys', force: :cascade do |t|
    DebugsBunny::EncryptionKey.table_descriptor.column_descriptors.each do |column|
      options = column.option_list.to_h
      if options.empty?
        t.send(column.type, column.name)
      else
        t.send(column.type, column.name, **options)
      end
    end
    t.timestamps
    DebugsBunny::EncryptionKey.table_descriptor.index_descriptors.each do |index|
      options = index.option_list.to_h
      if options.empty?
        t.send(:index, index.columns)
      else
        t.send(:index, index.columns, **options)
      end
    end
  end
end
