class RailsCasServer::LoginTicket < ActiveRecord::Base
  before_save :generate_ticket

  def generate_ticket
    self.ticket = SecureRandom.uuid
  end
end
