require 'active_support/concern'

module Ticket
  extend ActiveSupport::Concern

  included do
    before_save :generate_ticket
    scope :valid, ->(ticket) { where(ticket: ticket) }
    def generate_ticket
      self.ticket = "#{self.prefix}-#{SecureRandom.uuid}"
    end

    def to_s
      self.ticket
    end
  end

end
