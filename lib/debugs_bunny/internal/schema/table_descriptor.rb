# frozen_string_literal: true

require_relative 'column_descriptor'

module DebugsBunny
  module Internal
    module Schema
      class TableDescriptor
        attr_reader :name
        attr_reader :column_descriptors

        def initialize(name, *column_descriptors)
          @name = name
          @column_descriptors = Array(column_descriptors)
        end
      end
    end
  end
end
