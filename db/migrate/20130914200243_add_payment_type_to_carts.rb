class AddPaymentTypeToCarts < ActiveRecord::Migration
  def change
      add_column :carts, :payment_type_cd, :integer, :default=>0
  end
end
