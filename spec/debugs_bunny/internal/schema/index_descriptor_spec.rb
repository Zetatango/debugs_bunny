# frozen_string_literal: true

require 'spec_helper'

require 'debugs_bunny/internal/schema/index_descriptor'

RSpec.describe DebugsBunny::Internal::Schema::IndexDescriptor do
  let(:index_descriptor) { described_class.new(:my_unique_index, %w[name type], unique: true) }

  describe '#column_names' do
    it 'returns an array of column names encoded as a string' do
      column_names = index_descriptor.column_names
      expect(column_names).to eq '[:name, :type]'
    end
  end

  describe '#option_list' do
    it 'returns an OptionList populated by the constructor name and argument list' do
      option_list = index_descriptor.option_list
      expect(option_list.first.to_s).to eq 'name: :my_unique_index'
      expect(option_list.second.to_s).to eq 'unique: true'
    end
  end
end
