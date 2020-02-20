# frozen_string_literal: true

module DebugsBunny
  class Trace < DebugsBunny::ApplicationRecord
    has_guid 'trc'

    self.abstract_class = true
  end
end
