# frozen_string_literal: true

require 'active_record'

module DebugsBunny
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
