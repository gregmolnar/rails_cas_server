class RailsCasServer::ServiceTicket < ActiveRecord::Base
  include Ticket
  before_save :generate_cookie

  def prefix
    'ST'
  end

  def generate_cookie
    self.cookie = generate_ticket('TGC')
  end

end
