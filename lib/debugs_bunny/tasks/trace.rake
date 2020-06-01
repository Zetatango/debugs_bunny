# frozen_string_literal: true

namespace :debugs_bunny do
  desc 'Delete expired trace records'
  task delete_expired_traces: :environment do
    max_age = DebugsBunny.configuration.max_age
    DebugsBunny::Trace.older_than(max_age).delete_all
  end
end
