class CreateLoginTicket < ActiveRecord::Migration
  def change
    create_table :rails_cas_server_login_tickets do |t|
      t.string :ticket, null: false
      t.string :host, null: false
    end
    add_index :rails_cas_server_login_tickets, [:ticket, :host]
  end
end
