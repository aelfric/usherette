class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :cart
      t.belongs_to :performance

      t.timestamps
    end
    add_index :tickets, :cart_id
    add_index :tickets, :performance_id
  end
end
