require "active_support/core_ext/integer/time"
require_relative '../../app/service/generate.rb' # specify the path for generator file

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  # Certificates are created when environment is setup.
  Generate.new

  # set up environment with certificate and key that we have created.
  config.force_ssl = true
  config.ssl_cert = Rails.root.join("../../server.pem").to_s
  config.ssl_key = Rails.root.join("../../server.key").to_s

end
