class CertificatesController < ApplicationController
  def expiration
    cert_file_path = File.expand_path("../../../app/service/certificates/server.pem", __FILE__)
    cert = OpenSSL::X509::Certificate.new(File.read(cert_file_path))
    render json: { expiration_date: cert.not_after }
  end
end

# The file renders the json with expiration date, when the suitable route receives expiration end point.