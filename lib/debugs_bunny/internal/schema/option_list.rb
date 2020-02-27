# frozen_string_literal: true

module DebugsBunny
  module Internal
    module Schema
      class OptionList
        delegate_missing_to :options

        def initialize(options)
          @options = Array(options).map { |key, value| Option.new(key, value) }
        end

        def to_h
          options.each_with_object({}) { |option, hash| hash.merge! option.to_h }
        end

        def to_s
          options.map(&:to_s).join(', ')
        end

        private

        attr_reader :options
      end
    end
  end
end
