# frozen_string_literal: true

require 'spec_helper'
require 'models/debugs_bunny/concerns/has_encrypted_attributes'

class DebugTrace < DebugsBunny::Trace; end

RSpec.describe DebugsBunny::HasEncryptedAttributes do
  subject { DebugTrace }

  before do
    allow(Rails.logger).to receive(:error).and_call_original
  end

  shared_examples 'instantiation' do |instantiation_method|
    let(:instantiation_error_message) { /DebugsBunny failed to instantiate a new #{subject.name} record:/ }
    let(:instantiation_unknown_error_message) { /DebugsBunny failed to instantiate a new #{subject.name} record due to an unknown error:/ }

    it "logs an error message on #{instantiation_method} when DaffyLib raises EncryptionFailedException" do
      allow(DaffyLib::CachingEncryptor).to receive(:zt_encrypt).and_raise(DaffyLib::CachingEncryptor::EncryptionFailedException)
      expect { subject.send(instantiation_method, dump: 'test') }.not_to raise_error
      expect(Rails.logger).to have_received(:error).with(instantiation_error_message).once
      expect(Rails.logger).not_to have_received(:error).with(instantiation_unknown_error_message)
    end

    it "logs an error message on #{instantiation_method} when DaffyLib raises InvalidParameterException" do
      allow(DaffyLib::CachingEncryptor).to receive(:zt_encrypt).and_raise(DaffyLib::CachingEncryptor::InvalidParameterException)
      expect { subject.send(instantiation_method, dump: 'test') }.not_to raise_error
      expect(Rails.logger).to have_received(:error).with(instantiation_error_message).once
      expect(Rails.logger).not_to have_received(:error).with(instantiation_unknown_error_message)
    end

    it "logs an error message on #{instantiation_method} when any other exception is raised" do
      allow(DaffyLib::CachingEncryptor).to receive(:zt_encrypt).and_raise(StandardError, 'Something bad happened...')
      expect { subject.send(instantiation_method, dump: 'test') }.not_to raise_error
      expect(Rails.logger).not_to have_received(:error).with(instantiation_error_message)
      expect(Rails.logger).to have_received(:error).with(instantiation_unknown_error_message).once
    end
  end

  shared_examples 'decrypt' do
    let(:decrypt_error_message) { /DebugsBunny failed to decrypt dump:/ }
    let(:decrypt_unknown_error_message) { /DebugsBunny failed to decrypt dump due to an unknown error:/ }
    let(:instance) { create :debug_trace }
    let(:db_instance) { subject.find(instance.id) }

    it 'logs an error message on encrypted attribute read when DaffyLib raises DecryptionFailedException' do
      allow(DaffyLib::CachingEncryptor).to receive(:zt_decrypt).and_raise(DaffyLib::CachingEncryptor::DecryptionFailedException)
      expect { db_instance.dump }.not_to raise_error
      expect(Rails.logger).to have_received(:error).with(decrypt_error_message).once
      expect(Rails.logger).not_to have_received(:error).with(decrypt_unknown_error_message)
    end

    it 'logs an error message on encrypted attribute read when DaffyLib raises InvalidParameterException' do
      allow(DaffyLib::CachingEncryptor).to receive(:zt_decrypt).and_raise(DaffyLib::CachingEncryptor::InvalidParameterException)
      expect { db_instance.dump }.not_to raise_error
      expect(Rails.logger).to have_received(:error).with(decrypt_error_message).once
      expect(Rails.logger).not_to have_received(:error).with(decrypt_unknown_error_message)
    end

    it 'logs an error message on encrypted attribute read when any other exception is raised' do
      allow(DaffyLib::CachingEncryptor).to receive(:zt_decrypt).and_raise(StandardError)
      expect { db_instance.dump }.not_to raise_error
      expect(Rails.logger).not_to have_received(:error).with(decrypt_error_message)
      expect(Rails.logger).to have_received(:error).with(decrypt_unknown_error_message).once
    end
  end

  it_behaves_like 'instantiation', :new
  it_behaves_like 'instantiation', :create
  it_behaves_like 'instantiation', :create!
  it_behaves_like 'decrypt'
end
