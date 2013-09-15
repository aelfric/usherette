class AddDeliverTypeToPerformance < ActiveRecord::Migration
  def change
      add_column :performances, :delivery_type_cd, :integer, :default => 0
  end
end
