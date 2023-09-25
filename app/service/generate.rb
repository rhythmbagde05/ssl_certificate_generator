require 'openssl'

class Generate
  def initialize
    # Specify the folder path for saving the certificates
    @folder_path = "app/service/certificates/"

    root_params = create_ca
    cert_params = create_signed_cert(root_params[:root_ca], root_params[:root_key])
    save_cert(root_params[:root_key], root_params[:root_ca], cert_params[:cert], cert_params[:key])
  end

  def create_ca
    # Create a CA that will be used to sign certificates
  
    File.delete("#{@folder_path}CA.pem") if File.exist?("#{@folder_path}CA.pem")
    File.delete("#{@folder_path}CA.key") if File.exist?("#{@folder_path}CA.key")

    root_key = OpenSSL::PKey::RSA.new(2048)
    root_ca = OpenSSL::X509::Certificate.new
  
    root_ca.version = 2
    root_ca.serial = 1
    root_ca.subject = OpenSSL::X509::Name.parse("/C=US/O=MyCA/CN=MyCA-Root-CA")
    root_ca.issuer = root_ca.subject
    root_ca.public_key = root_key.public_key
    root_ca.not_before = Time.now
    root_ca.not_after = Time.now + 7 * 24 * 60 * 60        # 7 days expiration of certificates
    root_ca.sign(root_key, OpenSSL::Digest::SHA256.new)

    return { root_ca: root_ca, root_key: root_key}
  end

  def create_signed_cert(root_ca, root_key)
    # Create a certificate signed by the CA

    File.delete("#{@folder_path}server.pem") if File.exist?("#{@folder_path}server.pem")
    File.delete("#{@folder_path}server.key") if File.exist?("#{@folder_path}server.key")

    key = OpenSSL::PKey::RSA.new(2048)
    cert = OpenSSL::X509::Certificate.new

    cert.version = 2
    cert.serial = 2
    cert.subject = OpenSSL::X509::Name.parse("/C=US/O=MyServer/CN=localhost")
    cert.issuer = root_ca.subject
    cert.public_key = key.public_key
    cert.not_before = Time.now
    cert.not_after = Time.now + 7 * 24 * 60 * 60        # 7 days expiration of certificates
    cert.sign(root_key, OpenSSL::Digest::SHA256.new)
    
    return { cert: cert, key: key}
  end

  def save_cert(root_key, root_ca, cert, key)
    # Create a folder if it doesn't exist
    Dir.mkdir(@folder_path) unless File.directory?(@folder_path)
    
    # Save the files in the specified folder
    File.open("#{@folder_path}CA.pem", "wb") { |f| f.write(root_ca.to_pem) }
    File.open("#{@folder_path}CA.key", "wb") { |f| f.write(root_key.to_pem) }
    File.open("#{@folder_path}server.pem", "wb") { |f| f.write(cert.to_pem) }
    File.open("#{@folder_path}server.key", "wb") { |f| f.write(key.to_pem) }
  end   
end
