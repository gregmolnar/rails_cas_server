require 'test_helper'

class SqlAuthenticatorTest < ActiveSupport::TestCase
  setup do
    @database = { adapter: 'sqlite3', database: File.join(Rails.root, 'db', 'sql_auth_test.sqlite3') }
    ActiveRecord::Base.establish_connection(@database)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Schema.define do
      create_table :users do |t|
        t.string :username
        t.string :password
      end
    end
    ActiveRecord::Base.connection.execute("INSERT INTO users (username, password) VALUES ('johndoe', '123456')")
  end

  teardown do
    FileUtils.rm(File.join(Rails.root, 'db', 'sql_auth_test.sqlite3'))
  end
  test "it verifies login details" do
    authenticator = RailsCasServer::Authenticators::SqlAuthenticator
    authenticator.configure do |config|
      config.database = @database
      config.table = "users"
      config.username_field = :username
      config.password_field = :password
    end
    assert authenticator.new.verify('johndoe', '123456')
  end
end
