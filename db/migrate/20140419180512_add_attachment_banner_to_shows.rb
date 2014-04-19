class AddAttachmentBannerToShows < ActiveRecord::Migration
  def self.up
    change_table :shows do |t|
      t.attachment :banner
    end
  end

  def self.down
    drop_attached_file :shows, :banner
  end
end
