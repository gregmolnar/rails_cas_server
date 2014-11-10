class RailsCasServer::LoginTicket < ActiveRecord::Base
  before_save :generate_ticket
  scope :valid, ->(ticket) { where(ticket: ticket) }
  def generate_ticket
    self.ticket = SecureRandom.uuid
  end

  def to_s
    self.ticket
  end
end
