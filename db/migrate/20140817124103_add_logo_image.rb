class AddLogoImage < ActiveRecord::Migration
  def up
    change_table :shows do |t|
      t.attachment :logo
    end
  end

  def down
    drop_attached_file :shows, :logo
  end
end
