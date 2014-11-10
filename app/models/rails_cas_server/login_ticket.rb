class RailsCasServer::LoginTicket < ActiveRecord::Base
  include Ticket
  def prefix
    'LT'
  end
end
