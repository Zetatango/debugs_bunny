# frozen_string_literal: true

require 'active_support/concern'

require 'debugs_bunny/internal/schema/table_descriptor'

module DebugsBunny
  module CanGenerate
    extend ActiveSupport::Concern

    attr_reader :table_descriptor

    class_methods do
      def table_descriptor
        @table_descriptor ||= DebugsBunny::Internal::Schema::TableDescriptor.new
      end

      def define_table
        yield(table_descriptor)
      end
    end
  end
end
