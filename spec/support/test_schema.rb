# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table 'debug_traces', force: :cascade do |t|
    t.string 'guid'
    t.string 'dump'
    t.datetime 'created_at'
  end
end
