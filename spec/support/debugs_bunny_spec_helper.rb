# frozen_string_literal: true

module DebugsBunny
  ROOT_DIR = File.expand_path('../..', __dir__)
  SPEC_DIR = File.join(ROOT_DIR, 'spec')
  TMP_DIR = File.join(ROOT_DIR, 'tmp')
end

RSpec.configure do |config|
  config.include DebugsBunny
end
