# frozen_string_literal: true

require 'active_support/concern'

module DebugsBunny
  module HasEncryptedAttributes
    extend ActiveSupport::Concern

    included do
      require 'attr_encrypted'
      require 'daffy_lib'
      include DaffyLib::PartitionProvider
      include DaffyLib::HasEncryptedAttributes
    end

    class_methods do
      def set_encryption_options
        attr_encrypted_options.merge!(
          encryptor: DaffyLib::CachingEncryptor,
          encrypt_method: :zt_encrypt,
          decrypt_method: :zt_decrypt,
          partition_guid: proc { |object| object.generate_partition_guid },
          encryption_epoch: proc { |object| object.generate_encryption_epoch },
          cmk_key_id: proc { DebugsBunny.configuration.encryption_cmk_key_id },
          expires_in: proc { DebugsBunny.configuration.encryption_key_cache_timeout }
        )
      end

      def define_encrypted_attributes
        define_singleton_method(:set_encrypted_attributes) do
          set_encryption_options
          yield
        end
        set_encrypted_attributes
      end
    end
  end
end
