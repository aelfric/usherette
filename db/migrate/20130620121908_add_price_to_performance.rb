class AddPriceToPerformance < ActiveRecord::Migration
  def change
      add_column :performances, :price, :integer
  end
end
