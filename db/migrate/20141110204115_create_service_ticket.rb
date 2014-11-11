class CreateServiceTicket < ActiveRecord::Migration
  def change
    create_table :service_tickets do |t|
      t.string :ticket, null: false
      t.string :host, null: false
      t.string :username, null: false
      t.string :service
      t.string :session_id, null: false
      t.string :cookie, null: false
    end
    add_index :service_tickets, :ticket
    add_index :service_tickets, :cookie
    add_index :service_tickets, :session_id
  end
end
