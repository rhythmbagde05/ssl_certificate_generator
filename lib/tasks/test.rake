require_relative '../../app/service/client.rb' # specify the path for client file

namespace :test do
  desc 'Check server certificate expiration'
  task :check_server_certificate do
    Client.new
  end
end
  