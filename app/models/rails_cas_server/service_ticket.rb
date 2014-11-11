class RailsCasServer::ServiceTicket < ActiveRecord::Base
  include Ticket
  before_save :generate_cookie
  scope :not_consumed, -> { where(consumed_at: nil) }

  def prefix
    'ST'
  end

  def generate_cookie
    self.cookie = "TGC-#{SecureRandom.uuid}"
  end

  def consumed?
    !self.consumed_at.nil?
  end

  def consume!
    update_attribute(:consumed_at, Time.now)
  end

end
