# frozen_string_literal: true

require 'spec_helper'

class DebugTrace < DebugsBunny::Trace; end

RSpec.describe DebugTrace, type: :model do
  it 'is valid with valid parameters' do
    debug_trace = build :debug_trace
    expect(debug_trace).to be_valid
  end

  it 'is created with a guid' do
    debug_trace = create :debug_trace
    expect(debug_trace.guid).to be_present
  end

  it 'is created with a dump' do
    debug_trace = create :debug_trace
    expect(debug_trace.dump).to be_present
  end

  it 'is created with a timestamp' do
    debug_trace = create :debug_trace
    expect(debug_trace.created_at).to be_present
  end

  describe '::find_by' do
    it 'returns the record specified by the guid' do
      debug_trace = create :debug_trace
      found_record = described_class.find_by(guid: debug_trace.guid)
      expect(found_record).to eq debug_trace
    end
  end
end
