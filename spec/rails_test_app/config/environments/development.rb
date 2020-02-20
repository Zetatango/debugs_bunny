# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  config.action_controller.perform_caching = false

  config.cache_store = :null_store

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
end
