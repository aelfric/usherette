class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.belongs_to :show
      t.belongs_to :venue
      t.datetime :date

      t.timestamps
    end
    add_index :performances, :show_id
    add_index :performances, :venue_id
  end
end
