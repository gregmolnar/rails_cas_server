module RailsCasServer
  module Authenticators
    class Base
      def verify(*args)
        raise NotImplementedError, "This method must be implemented by an authenticator"
      end
    end
  end
end