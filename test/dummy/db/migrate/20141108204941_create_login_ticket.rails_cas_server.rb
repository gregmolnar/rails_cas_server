# This migration comes from rails_cas_server (originally 20140907213834)
class CreateLoginTicket < ActiveRecord::Migration
  def change
    create_table :login_tickets do |t|
      t.string :ticket, null: false
      t.string :host, null: false
    end
    add_index :login_tickets, [:ticket, :host]
  end
end
