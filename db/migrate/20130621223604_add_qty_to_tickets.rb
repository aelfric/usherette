class AddQtyToTickets < ActiveRecord::Migration
  def change
      add_column :tickets, :quantity, :integer, :default => 1
  end
end
