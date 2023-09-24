require 'restclient'
require 'json'
require 'pathname'
require 'time'
require_relative 'app/service/generate.rb'

# defining the path of certificate
server_pem_path = File.expand_path('app/service/certificates/server.pem', File.dirname(__FILE__))
url = 'https://localhost:3000/expiration'

begin
  #restclient for hitting the server
  response = RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE, ssl_ca_file: server_pem_path).get
  data = JSON.parse(response.body)

  # Parse the date to desired format and handle certificate expiration.
  expiration_date = Time.parse(data['expiration_date']) 

  if expiration_date > Time.now
    formatted_date = expiration_date.strftime('%d %B %Y %H:%M:%S')
    puts "Server certificate expiration date and time: #{formatted_date}"
  else
    puts "Server certificate has expired, please regenrate"
  end
rescue RestClient::ExceptionWithResponse => e
  # Handle RestClient exceptions
  puts "RestClient Exception: #{e.response.code} - #{e.response.body}"
rescue JSON::ParserError => e
  # Handle JSON parsing errors
  puts "JSON Parsing Error: #{e.message}"
rescue StandardError => e
  # Handle other standard errors
  puts "Error: #{e.message}"
end
