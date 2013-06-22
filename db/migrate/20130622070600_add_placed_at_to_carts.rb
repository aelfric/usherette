class AddPlacedAtToCarts < ActiveRecord::Migration
  def change
      add_column :carts, :placed_at, :datetime
  end
end
