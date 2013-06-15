class AddNameAndEmailToCart < ActiveRecord::Migration
  def change
      add_column :carts, :order_firstname, :string
      add_column :carts, :order_lastname, :string
      add_column :carts, :order_email, :string
  end
end
