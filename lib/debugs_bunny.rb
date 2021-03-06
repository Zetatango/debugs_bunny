# frozen_string_literal: true

require 'models/debugs_bunny/concerns/can_generate'
require 'models/debugs_bunny/concerns/has_encrypted_attributes'
require 'models/debugs_bunny/concerns/has_guid'
require 'models/debugs_bunny/application_record'
require 'models/debugs_bunny/trace'
require 'debugs_bunny/version'

require 'debugs_bunny/railtie' if defined?(Rails)

module DebugsBunny
  LIB_DIR = File.expand_path('./debugs_bunny', __dir__)
  INTERNAL_DIR = File.join(LIB_DIR, 'internal')
  TEMPLATES_DIR = File.join(INTERNAL_DIR, 'templates')
  TASKS_DIR = File.join(LIB_DIR, 'tasks')
end
