class CreateLoginTicket < ActiveRecord::Migration
  def change
    create_table :login_tickets do |t|
      t.string :ticket, null: false
      t.string :host, null: false
      t.timestamps
    end
    add_index :login_tickets, [:ticket, :host]
  end
end
