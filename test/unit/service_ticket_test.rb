require 'test_helper'

class ServiceTicketTest < ActiveSupport::TestCase

  test "it becomes consumed when updated" do
    ticket = RailsCasServer::ServiceTicket.create!(username: 'foo', host: '0.0.0.0', session_id: 'foo')
    assert_not ticket.consumed?
    ticket.consume!
    assert ticket.reload.consumed?
  end
end
