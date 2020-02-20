# frozen_string_literal: true

require 'models/debugs_bunny/concerns/has_guid'

class DebugTrace < DebugsBunny::Trace; end

RSpec.describe DebugsBunny::HasGuid do
  context 'when creating a record' do
    it 'generates a guid for the record' do
      trace = create :debug_trace
      expect(trace.guid).to start_with DebugTrace.has_guid_prefix
    end

    it 'allows records to specify a guid' do
      guid = DebugTrace.has_guid_prefix + '_123'
      trace = create :debug_trace, guid: guid
      expect(trace.guid).to eq guid
    end
  end

  context 'when duplicating a record' do
    let(:trace) { create :debug_trace }

    it 'generates a new guid for the duplicate record' do
      duplicate = trace.dup
      expect(duplicate.guid).to be_nil
      expect(duplicate.id).to be_nil
      duplicate.save!
      expect(duplicate.guid).to start_with DebugTrace.has_guid_prefix
    end
  end

  describe '#save' do
    it 'generates a new guid for the record if the guid is blank' do
      trace = build :debug_trace, guid: ''
      trace.save!
      expect(trace.guid).to start_with DebugTrace.has_guid_prefix
    end

    it 'generates a new guid for the record if the guid is nil' do
      trace = build :debug_trace, guid: nil
      trace.save!
      expect(trace.guid).to start_with DebugTrace.has_guid_prefix
    end
  end

  describe '#to_param' do
    it 'returns the guid' do
      trace = create :debug_trace
      expect(trace.to_param).to equal trace.guid
    end
  end

  it 'enforces a globally unique prefix' do
    expect do
      klass = Class.new(DebugsBunny::Trace)
      klass.has_guid DebugTrace.has_guid_prefix
    end.to raise_error ArgumentError
  end

  it 'enforces immutable guids' do
    expect do
      trace = create :debug_trace
      trace.guid = DebugTrace.has_guid_prefix + "_#{SecureRandom.base58(16)}"
      trace.save!
    end.to raise_error ActiveRecord::RecordInvalid
  end
end
