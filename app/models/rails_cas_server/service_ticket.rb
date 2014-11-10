class RailsCasServer::ServiceTicket < ActiveRecord::Base
  include Ticket
  def prefix
    'ST'
  end

end
