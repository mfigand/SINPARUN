class AddAttachmentImageToRewards < ActiveRecord::Migration
  def self.up
    change_table :rewards do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :rewards, :image
  end
end
