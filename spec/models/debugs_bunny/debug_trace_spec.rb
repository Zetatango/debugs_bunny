# frozen_string_literal: true

require 'spec_helper'

class DebugTrace < DebugsBunny::Trace; end

RSpec.describe DebugTrace, type: :model do
  it 'is valid with valid parameters' do
    debug_trace = build :debug_trace
    expect(debug_trace).to be_valid
  end

  it 'is valid without a dump' do
    debug_trace = build :debug_trace, dump: nil
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

  it 'is loaded with the created dump' do
    debug_trace = create :debug_trace, dump: 'test'
    db_debug_trace = described_class.find(debug_trace.id)
    expect(db_debug_trace.dump).to eq 'test'
  end

  it 'is created with a timestamp' do
    debug_trace = create :debug_trace
    expect(debug_trace.created_at).to be_present
  end

  describe '::find_by' do
    let(:debug_trace) { create :debug_trace }

    it 'returns the record specified by the guid' do
      found_record = described_class.find_by(guid: debug_trace.guid)
      expect(found_record).to eq debug_trace
    end
  end

  describe '::created_before' do
    let(:debug_trace_1) { create :debug_trace, created_at: Time.now.utc }
    let(:debug_trace_2) { create :debug_trace, created_at: Time.now.utc - 3.days }

    before do
      debug_trace_1
      debug_trace_2
    end

    it 'returns all records created before the given time' do
      traces = described_class.created_before(Time.now.utc - 1.day)
      expect(traces.length).to eq 1
      expect(traces.first).to eq debug_trace_2
    end

    it 'returns no records if no records have been created before the given time' do
      traces = described_class.created_before(Time.now.utc - 1.week)
      expect(traces.length).to eq 0
    end
  end

  describe '::created_after' do
    let(:debug_trace_1) { create :debug_trace, created_at: Time.now.utc - 1.day }
    let(:debug_trace_2) { create :debug_trace, created_at: Time.now.utc - 3.days }

    before do
      debug_trace_1
      debug_trace_2
    end

    it 'returns all records created after the given time' do
      traces = described_class.created_after(Time.now.utc - 2.days)
      expect(traces.length).to eq 1
      expect(traces.first).to eq debug_trace_1
    end

    it 'returns no records if no records have been created after the given time' do
      traces = described_class.created_after(Time.now.utc)
      expect(traces.length).to eq 0
    end
  end

  describe '::created_between' do
    let(:debug_trace_1) { create :debug_trace, created_at: Time.now.utc - 1.day }
    let(:debug_trace_2) { create :debug_trace, created_at: Time.now.utc - 3.days }

    before do
      debug_trace_1
      debug_trace_2
    end

    it 'returns all records created between the given time range' do
      traces = described_class.created_between(Time.now.utc - 1.week..Time.now.utc)
      expect(traces.length).to eq 2
      expect(traces.first).to eq debug_trace_1
      expect(traces.second).to eq debug_trace_2
    end

    it 'returns no records if no records have been created between the given time range' do
      traces = described_class.created_between(Time.now.utc - 2.months..Time.now.utc - 1.month)
      expect(traces.length).to eq 0
    end
  end

  describe '::older_than' do
    let(:debug_trace_1) { create :debug_trace, created_at: Time.now.utc - 1.day }
    let(:debug_trace_2) { create :debug_trace, created_at: Time.now.utc - 3.days }

    before do
      debug_trace_1
      debug_trace_2
    end

    it 'returns all records older than the given age' do
      traces = described_class.older_than(2.days)
      expect(traces.length).to eq 1
      expect(traces.first).to eq debug_trace_2
    end

    it 'returns no records if no records are older than the given age' do
      traces = described_class.older_than(1.week)
      expect(traces.length).to eq 0
    end
  end

  describe '::newer_than' do
    let(:debug_trace_1) { create :debug_trace, created_at: Time.now.utc - 1.day }
    let(:debug_trace_2) { create :debug_trace, created_at: Time.now.utc - 3.days }

    before do
      debug_trace_1
      debug_trace_2
    end

    it 'returns all records newer than the given age' do
      traces = described_class.newer_than(2.days)
      expect(traces.length).to eq 1
      expect(traces.first).to eq debug_trace_1
    end

    it 'returns no records if no records are newer than the given age' do
      traces = described_class.newer_than(1.minute)
      expect(traces.length).to eq 0
    end
  end
end
