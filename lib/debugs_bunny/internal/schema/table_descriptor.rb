# frozen_string_literal: true

require_relative 'column_descriptor'
require_relative 'index_descriptor'

module DebugsBunny
  module Internal
    module Schema
      class TableDescriptor
        attr_accessor :name
        attr_reader :column_descriptors, :index_descriptors

        def initialize(name = '')
          @name = name
          @column_descriptors = []
          @index_descriptors = []
        end

        def define_column(name, type, options = {})
          column_descriptor = Schema::ColumnDescriptor.new(name, type, options)
          add_column_descriptor(column_descriptor)
        end

        def define_index(name, columns, options = {})
          index_descriptor = Schema::IndexDescriptor.new(name, columns, options)
          add_index_descriptor(index_descriptor)
        end

        def add_column_descriptor(column_descriptor)
          @column_descriptors << column_descriptor
        end

        def add_index_descriptor(index)
          @index_descriptors << index
        end
      end
    end
  end
end
