Rails.application.routes.draw do
  # defining a route for clients requests to check the expiration of the certificates.
  get '/expiration', to: 'certificates#expiration'
end
