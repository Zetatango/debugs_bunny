# frozen_string_literal: true

FactoryBot.define do
  factory :debug_trace, class: 'DebugTrace' do
    dump { 'Mr. Gorbachev, tear down this wall.' }
  end
end
