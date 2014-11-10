require "rails_cas_server/engine"
require "rails_cas_server/authenticators/base"
require "rails_cas_server/authenticators/sql_authenticator"

module RailsCasServer

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :authenticator, :allowed_services
  end

  class ConfigurationError < Exception
  end
end
