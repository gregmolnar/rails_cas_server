module RailsCasServer
  module Authenticators
    class SqlAuthenticator < Base
      class << self
        attr_accessor :configuration
      end

      def self.configuration
        @configuration ||= Configuration.new
      end

      def self.configure
        yield(configuration)
      end

      def verify(username, password)
        User.establish_connection(SqlAuthenticator.configuration.database)
        User.table_name = SqlAuthenticator.configuration.table
        user = User.where("#{SqlAuthenticator.configuration.username_field} = ?", username).first
        (user && user.password === password)
      end

      class Configuration
        attr_accessor :database, :table, :username_field, :password_field
      end

      class User < ActiveRecord::Base
      end
    end
  end
end