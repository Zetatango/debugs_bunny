# frozen_string_literal: true

require 'models/debugs_bunny/concerns/has_guid'

class DebugTrace < DebugsBunny::Trace; end

RSpec.describe DebugsBunny::HasGuid do
  let(:trace) { create :debug_trace }

  it 'duplicated encryption_key have no guid but get one when they are saved' do
    duplicate = trace.dup
    expect(duplicate.guid).to be_nil
    expect(duplicate.id).to be_nil
    duplicate.save!
    expect(duplicate.guid).to start_with DebugTrace.has_guid_prefix
  end

  it '#to_param returns the guid' do
    expect(trace.to_param).to equal trace.guid
  end

  it 'blank guid on create generates a guid' do
    duplicate = trace.dup
    duplicate.guid = ''
    duplicate.save!
    expect(duplicate.guid).to start_with DebugTrace.has_guid_prefix

    duplicate = trace.dup
    duplicate.guid = nil
    duplicate.save!
    expect(duplicate.guid).to start_with DebugTrace.has_guid_prefix
  end

  it 'prefix is globally unique' do
    expect do
      klass = Class.new(DebugsBunny::Trace)
      klass.has_guid 'trc'
    end.to raise_error ArgumentError
  end

  it 'guid cannot be changed' do
    expect do
      trace.guid = "trc_#{SecureRandom.base58(16)}"
      trace.save!
    end.to raise_error ActiveRecord::RecordInvalid
  end
end
