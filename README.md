# A self-signed certificate generator.



https://github.com/rhythmbagde05/ssl_certificate_generator/assets/145548717/57c05e62-6289-48b0-9e78-9198b1e30076


## Description

Created a self-signed certificate generator, which involved the creation of a Certificate Authority (CA) and a certificate signed by that CA. Dveloped a basic web server using the generated SSL certificates. Developed a test connection program for verifying certificate expiration dates. Utilized the generated CA certificate to check the expiration date of the server certificate and then presented the result.

## Getting Started

### Dependencies

Installation of these dependencies can be done by homebrew in macOS and downloaded from web in windows/linux.

* Ruby version 3.2.1 - brew install ruby or download from official website
* rvm version 1.29.12 - brew install rvm
* OpenSSL version 3.1.3 - brew install openssl or download from official website
* Rails version 7.8.0 - gem install rails
* Git version 2.42.0 - brew install git or download from official website

### Installing

* Once you have installed Git, use the following command to clone the repository.
```
git clone https://github.com/rhythmbagde05/ssl_certificate_generator
```
* Go inside the repository
```
cd ssl_certificate_generator
```
* Install bundler 
```
gem install bundler
```
* Install extra gems that are used
```
gem install openssl
gem install rest-client
```
* Install gemfile
```
bundle install
```


### Executing program

* Strating the server - on one terminal tab - Once the environment loads, it will automatically generates the certificates inside app/service/certificates
```
rake server
```
* Testing the connection through a client code - on another terminal tab - it returns back the expiration date and time of the certificates
```
rake test
```
