class AddFirstnameAndLastnameToUsers < ActiveRecord::Migration
  def change
      add_column :users, :firstname, :string, :default=>''
      add_column :users, :lastname, :string, :default=>''
  end
end
