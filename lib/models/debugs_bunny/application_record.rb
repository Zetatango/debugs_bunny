# frozen_string_literal: true

require 'active_record'

require_relative 'concerns/has_guid'

module DebugsBunny
  class ApplicationRecord < ActiveRecord::Base
    include HasGuid

    self.abstract_class = true
  end
end
