# frozen_string_literal: true

module DebugsBunny
  module Internal
    module Schema
      class Option
        def initialize(key, value)
          @key = key
          @value = value
        end

        def to_h
          {
            "#{key}": value
          }
        end

        def to_s
          value_s = if value.is_a? String
                      "'#{value}'"
                    elsif value.is_a? Symbol
                      ":#{value}"
                    else
                      value
                    end
          "#{key}: #{value_s}"
        end

        private

        attr_reader :key, :value
      end
    end
  end
end
