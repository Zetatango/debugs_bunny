# frozen_string_literal: true

require_relative 'column_descriptor'
require_relative 'option'

module DebugsBunny
  module Internal
    module Schema
      class IndexDescriptor
        attr_reader :columns, :option_list

        def initialize(name, columns, options = {})
          @columns = Array(columns.map(&:to_sym))
          @option_list = OptionList.new(options.merge(name: name))
        end

        def column_names
          @columns.to_s
        end
      end
    end
  end
end
