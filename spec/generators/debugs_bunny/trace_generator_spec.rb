# frozen_string_literal: true

require 'generators/debugs_bunny/trace/trace_generator'

RSpec.describe DebugsBunny::TraceGenerator, type: :generator do
  let(:model_name) { 'DebugTrace' }
  let(:file_name) { 'debug_trace.rb' }

  it 'creates a model file with the given file name' do
    run_generator model_name
    path = model_file(file_name)
    expect(File).to exist(path)
  end

  it 'creates a model with the given model name' do
    run_generator model_name
    path = model_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "class #{model_name}"
    end
  end

  it 'creates a model that inherits from Trace' do
    run_generator model_name
    path = model_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "class #{model_name} < DebugsBunny::Trace"
    end
  end
end
