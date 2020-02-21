# frozen_string_literal: true

require 'spec_helper'

require 'debugs_bunny/internal/schema/column_descriptor'

RSpec.describe DebugsBunny::Internal::Schema::ColumnDescriptor do
  describe described_class::Option do
    let(:option) { described_class.new(:option, true) }

    describe '#to_s' do
      it 'returns the Option as a key-value string' do
        str = option.to_s
        expect(str).to eq 'option: true'
      end
    end
  end

  describe described_class::OptionList do
    let(:option_list) do
      options = [
        DebugsBunny::Internal::Schema::ColumnDescriptor::Option.new(:colour, :blue),
        DebugsBunny::Internal::Schema::ColumnDescriptor::Option.new(:size, :medium)
      ]
      described_class.new(options)
    end

    describe '#to_s' do
      it 'returns the OptionList as a list of key-value strings' do
        str = option_list.to_s
        expect(str).to eq 'colour: blue, size: medium'
      end
    end
  end

  describe '#option_list' do
    let(:column_descriptor) { described_class.new(:text, :string, null: false, default: 'Hello World') }

    it 'returns an OptionList populated by the constructor argument list' do
      option_list = column_descriptor.option_list
      expect(option_list.length).to be 2
      expect(option_list.first.to_s).to eq 'null: false'
      expect(option_list.second.to_s).to eq 'default: Hello World'
    end
  end
end
