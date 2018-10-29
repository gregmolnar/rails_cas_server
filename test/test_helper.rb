# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "pry"
Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end
RailsCasServer.configure do |config|
  config.allowed_services = {
    'myservice.mytld' => ['127.0.0.1']
  }
end

unless ActiveRecord::Base.connection.data_source_exists?(:users)
  ActiveRecord::Schema.define do
    create_table :users do |t|
      t.string :username
      t.string :password
    end
  end
  RailsCasServer::Authenticators::SqlAuthenticator::User.create!(username: 'johndoe', password: '123456')
end
