# frozen_string_literal: true

require 'spec_helper'

require 'generators/debugs_bunny/initializer/config/config_generator'

RSpec.describe DebugsBunny::ConfigGenerator, type: :generator do
  before do
    clone_test_project
    run_generator
  end

  after do
    remove_test_project
  end

  it 'creates an initializer file with the expected file name' do
    path = initializer_file('debugs_bunny.rb')
    expect(File).to exist(path)
  end
end
