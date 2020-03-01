# frozen_string_literal: true

module DebugsBunny
  class Config
    @default_config = {
      encryption_cmk_key_id: nil,
      encryption_key_cache_timeout: 5.minutes,
      encryption_partition_guid: 'DEBUGS_BUNNY_PARTITION'
    }
    @allowed_config_keys = @default_config.keys

    class << self
      attr_reader :default_config, :allowed_config_keys
    end

    attr_reader :config

    def initialize
      @config = OpenStruct.new Config.default_config
    end

    def configure(options)
      options.each { |key, value| @config.send("#{key.to_sym}=", value) if Config.allowed_config_keys.include? key.to_sym }
    end
  end

  mattr_reader :configuration do
    @config ||= Config.new.config
  end
end
