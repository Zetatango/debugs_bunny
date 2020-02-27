# frozen_string_literal: true

require 'debugs_bunny/internal/schema/option'

RSpec.describe DebugsBunny::Internal::Schema::Option do
  describe '#to_h' do
    it 'returns the Option as a key-value hash' do
      option = described_class.new(:option, true)
      hash = option.to_h
      expect(hash).to eq(option: true)
    end
  end

  describe '#to_s' do
    it 'returns the Option as a key-value string for boolean values' do
      option = described_class.new(:option, true)
      str = option.to_s
      expect(str).to eq 'option: true'
    end

    it 'returns the Option as a key-value string for numeric values' do
      option = described_class.new(:option, 42)
      str = option.to_s
      expect(str).to eq 'option: 42'
    end

    it 'returns the Option as a key-value string for string values' do
      option = described_class.new(:option, 'Hello')
      str = option.to_s
      expect(str).to eq "option: 'Hello'"
    end
  end
end
