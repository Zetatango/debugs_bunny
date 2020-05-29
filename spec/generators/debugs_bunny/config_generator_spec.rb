# frozen_string_literal: true

require 'generators/debugs_bunny/config/config_generator'

RSpec.describe DebugsBunny::ConfigGenerator, type: :generator do
  it 'creates an initializer file with the expected file name' do
    run_generator
    path = initializer_file('debugs_bunny.rb')
    expect(File).to exist(path)
  end
end
