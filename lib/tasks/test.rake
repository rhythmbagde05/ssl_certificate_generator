namespace :test do
  desc 'Check server certificate expiration'
  task :check_server_certificate do
    script_path = File.expand_path('../../../app/service/client.rb', __FILE__)
    system("cd #{File.dirname(script_path)} && ruby #{script_path}")
  end
end
  