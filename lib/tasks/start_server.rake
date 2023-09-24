namespace :server do
  desc "Start the server with SSL"
  task :start_ssl_server do
    key_path = File.expand_path("../../../app/service/certificates/server.key", __FILE__)
    cert_path = File.expand_path("../../../app/service/certificates/server.pem", __FILE__)
    puts "Starting the server with SSL..."
    system("rails server -b 'ssl://0.0.0.0:3000?key=#{key_path}&cert=#{cert_path}'")
  end
end

#rake setup for starting the server with key and certificate.
