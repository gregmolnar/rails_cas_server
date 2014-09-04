require 'test_helper'

class BaseAuthenticatorTest < ActiveSupport::TestCase

  test "verify is not implemented" do
    assert_raise NotImplementedError do
      RailsCasServer::Authenticators::Base.new.verify
    end
  end
end
