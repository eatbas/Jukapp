SimpleTokenAuthentication.configure do |config|
  config.header_names = { user: { authentication_token: 'X-AuthToken', username: 'X-Username' } }
  config.identifiers = { user: 'username' }
end
