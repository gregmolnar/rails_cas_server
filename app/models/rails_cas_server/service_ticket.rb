class RailsCasServer::ServiceTicket < ActiveRecord::Base
  include Ticket
  before_save :generate_cookie

  def prefix
    'ST'
  end

  def generate_cookie
    self.cookie = generate_ticket('TGC')
  end

  def consumed?
    !self.consumed_at.nil?
  end

  def consume!
    update_attribute(:consumed_at, Time.now)
  end

end
