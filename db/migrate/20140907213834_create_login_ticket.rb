class CreateLoginTicket < ActiveRecord::Migration
  def change
    create_table :login_tickets do |t|
      t.string :ticket, null: false
      t.string :host, null: false
    end
  end
end
