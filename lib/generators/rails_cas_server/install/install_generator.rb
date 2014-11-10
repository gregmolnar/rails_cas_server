module RailsCasServer
  class InstallGenerator < Rails::Generators::Base
    desc "This generator creates an initializer file at config/initializers"
    def create_initializer
      create_file "config/initializers/config.rb", "
# authenticator = RailsCasServer::Authenticators::SqlAuthenticator
# authenticator.configure do |config|
#   config.table = :users
#   config.username_field = :username
#   config.password_field = :password
# end

# class DummyAuthenticator < RailsCasServer::Authenticators::Base
#   def verify(username, password)
#     username == 'admin' && password == 'p@ssword'
#   end
# end
# authenticator = DummyAuthenticator

RailsCasServer.configure do |config|
  config.authenticator = authenticator
end
"
    end

  end
end