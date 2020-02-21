# frozen_string_literal: true

module DebugsBunny
  module Internal
    module Schema
      class ColumnDescriptor
        class Option
          def initialize(key, value)
            @key = key
            @value = value
          end

          def to_s
            "#{key}: #{value}"
          end

          private

          attr_reader :key, :value
        end

        class OptionList
          delegate_missing_to :options

          def initialize(options)
            @options = Array(options)
          end

          def to_s
            options.map(&:to_s).join(', ')
          end

          private

          attr_reader :options
        end

        attr_reader :name, :type, :option_list

        def initialize(name, type, options = {})
          @name = name
          @type = type
          @option_list = OptionList.new(options.map { |key, value| Option.new(key, value) })
        end
      end
    end
  end
end
