require 'test_helper'

class SqlAuthenticatorTest < ActiveSupport::TestCase
  setup do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  test "it verifies login details" do
    authenticator = RailsCasServer::Authenticators::SqlAuthenticator
    authenticator.configure do |config|
      config.database = { adapter: 'sqlite3', database: File.join(Rails.root, 'db', 'test.sqlite3') }
      config.table = "users"
      config.username_field = :username
      config.password_field = :password
    end
    assert authenticator.new.verify('johndoe', '123456')
  end
end
