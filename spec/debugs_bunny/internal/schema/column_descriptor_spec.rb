# frozen_string_literal: true

require 'spec_helper'

require 'debugs_bunny/internal/schema/column_descriptor'

RSpec.describe DebugsBunny::Internal::Schema::ColumnDescriptor do
  describe '#option_list' do
    let(:column_descriptor) { described_class.new(:text, :string, null: false, default: 'Hello World') }

    it 'returns an OptionList populated by the constructor argument list' do
      option_list = column_descriptor.option_list
      expect(option_list.length).to be 2
      expect(option_list.first.to_s).to eq 'null: false'
      expect(option_list.second.to_s).to eq "default: 'Hello World'"
    end
  end
end
