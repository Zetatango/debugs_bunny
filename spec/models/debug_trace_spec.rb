# frozen_string_literal: true

require 'spec_helper'

class DebugTrace < DebugsBunny::Trace; end

FactoryBot.define do
  factory :debug_trace, class: 'DebugTrace' do
    guid { 'dbg_123' } # TODO: remove manual guid when automatic guid creation is implemented
    dump { 'Mr. Gorbachev, tear down this wall.' }
  end
end

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
end