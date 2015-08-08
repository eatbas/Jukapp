SimpleTokenAuthentication.configure do |config|
  config.header_names = { user: { authentication_token: 'X-User-Token', email: 'X-Username' } }
  config.identifiers = { user: 'username' }
end
