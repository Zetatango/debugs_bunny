# frozen_string_literal: true

require 'spec_helper'

require 'generators/debugs_bunny/trace/trace_generator'

RSpec.describe DebugsBunny::TraceGenerator, type: :generator do
  let(:model_name) { 'DebugTrace' }
  let(:file_name) { 'debug_trace.rb' }

  before do
    clone_test_project
    run_generator model_name
  end

  after do
    remove_test_project
  end

  it 'creates a model file with the given file name' do
    path = model_file(file_name)
    expect(File).to exist(path)
  end

  it 'creates a model with the given model name' do
    path = model_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "class #{model_name}"
    end
  end

  it 'creates a model that inherits from Trace' do
    path = model_file(file_name)
    read_file(path) do |contents|
      expect(contents).to include "class #{model_name} < DebugsBunny::Trace"
    end
  end
end
