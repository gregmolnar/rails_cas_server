require 'test_helper'

class LoginTicketTest < ActiveSupport::TestCase
  setup do

  end

  test "it generates ticket when created" do
    ticket = RailsCasServer::LoginTicket.create!(host: '0.0.0.0')
    assert_not_nil ticket.ticket
  end

end
