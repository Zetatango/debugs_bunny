# frozen_string_literal: true

require_relative 'concerns/can_generate'

module DebugsBunny
  class Trace < DebugsBunny::ApplicationRecord
    include CanGenerate

    self.abstract_class = true

    has_guid 'trc'

    define_table do |t|
      t.define_column :guid, :string, null: false
      t.define_column :dump, :string
    end
  end
end
