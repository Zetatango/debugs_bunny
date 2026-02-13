# frozen_string_literal: true

require 'active_support/concern'
require 'daffy_lib'

module DebugsBunny
  module HasEncryptedAttributes
    extend ActiveSupport::Concern

    module InstantiationErrors
      extend ActiveSupport::Concern

      DAFFY_LIB_HANDLED_ERRORS = [
        ::DaffyLib::CachingEncryptor::EncryptionFailedException,
        ::DaffyLib::CachingEncryptor::InvalidParameterException
      ].freeze

      class_methods do
        def new(*args, &block)
          if args.first&.delete(:skip_handle_errors)
            super
          else
            handle_instantiation_errors { super }
          end
        end

        def create(*args)
          # Signal that errors should be not be handled within new
          args.first&.merge!(skip_handle_errors: true)
          handle_instantiation_errors { super }
        end

        def create!(*args)
          # Signal that errors should be not be handled within new
          args.first&.merge!(skip_handle_errors: true)
          handle_instantiation_errors { super }
        end

        def handle_instantiation_errors
          yield
        rescue *DAFFY_LIB_HANDLED_ERRORS => e
          message = "DebugsBunny failed to instantiate a new #{name} record:\n"\
                    "#{e.message}\n"\
                    'Have you configured DebugsBunny and PorkyLib?'
          Rails.logger.error(message)
        rescue StandardError => e
          message = "DebugsBunny failed to instantiate a new #{name} record due to an unknown error:\n"\
                    "#{e.message}"
          Rails.logger.error(message)
        end
      end
    end

    module DecryptionErrors
      extend ActiveSupport::Concern

      DAFFY_LIB_HANDLED_ERRORS = [
        ::DaffyLib::CachingEncryptor::DecryptionFailedException,
        ::DaffyLib::CachingEncryptor::InvalidParameterException
      ].freeze

      def attr_encrypted_decrypt(attribute, *args)
        handle_decryption_errors(attribute) { super }
      end

      def handle_decryption_errors(attribute)
        yield
      rescue *DAFFY_LIB_HANDLED_ERRORS => e
        message = "DebugsBunny failed to decrypt #{attribute}:\n"\
                  "#{e.message}\n"
        Rails.logger.error(message)
      rescue StandardError => e
        message = "DebugsBunny failed to decrypt #{attribute} due to an unknown error:\n"\
                  "#{e.message}"
        Rails.logger.error(message)
      end
    end

    included do
      require 'attr_encrypted'
      include ::DaffyLib::PartitionProvider
      include ::DaffyLib::HasEncryptedAttributes
      include InstantiationErrors
      include DecryptionErrors
    end

    class_methods do
      def set_encryption_options
        attr_encrypted_options.merge!(
          encryptor: ::DaffyLib::CachingEncryptor,
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
