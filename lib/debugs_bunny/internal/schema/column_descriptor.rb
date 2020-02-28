# frozen_string_literal: true

require_relative 'option_list'

module DebugsBunny
  module Internal
    module Schema
      class ColumnDescriptor
        attr_reader :name, :type, :option_list

        def initialize(name, type, options = {})
          @name = name
          @type = type
          @option_list = OptionList.new(options)
        end
      end
    end
  end
end
