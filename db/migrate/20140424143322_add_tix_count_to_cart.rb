class AddTixCountToCart < ActiveRecord::Migration
  def change
      add_column :carts, :tickets_count, :integer, :default => 0
      say "Column added"

      Cart.reset_column_information
      Cart.all.each do |c|
          c.update_attribute :tickets_count, c.tickets.length
          say "Updating cart #{c.id}"
      end
  end
end
