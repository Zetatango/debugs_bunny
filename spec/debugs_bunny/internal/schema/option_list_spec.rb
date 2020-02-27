# frozen_string_literal: true

require 'debugs_bunny/internal/schema/option_list'

RSpec.describe DebugsBunny::Internal::Schema::OptionList do
  describe '#to_h' do
    let(:option_list) do
      options = { colour: :blue, size: :medium }
      described_class.new(options)
    end

    it 'returns the OptionList as a hash of key-values' do
      hash = option_list.to_h
      expect(hash).to eq(
        colour: :blue,
        size: :medium
      )
    end
  end

  describe '#to_s' do
    let(:option_list) do
      options = { colour: :blue, size: :medium }
      described_class.new(options)
    end

    it 'returns the OptionList as a list of key-value strings' do
      str = option_list.to_s
      expect(str).to eq 'colour: :blue, size: :medium'
    end
  end

  describe '#blank?' do
    it 'returns true if the OptionList contains no Options' do
      option_list = described_class.new({})
      expect(option_list).to be_blank
    end

    it 'returns false if the OptionList contains Options' do
      options = { colour: :blue, size: :medium }
      option_list = described_class.new(options)
      expect(option_list).not_to be_blank
    end
  end

  describe '#present?' do
    it 'returns true if the OptionList contains Options' do
      options = { colour: :blue, size: :medium }
      option_list = described_class.new(options)
      expect(option_list).to be_present
    end

    it 'returns false if the OptionList contains no Options' do
      option_list = described_class.new({})
      expect(option_list).not_to be_present
    end
  end
end
