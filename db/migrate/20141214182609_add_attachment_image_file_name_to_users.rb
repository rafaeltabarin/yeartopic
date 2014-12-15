class AddAttachmentImageFileNameToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :image_file_name
    end
  end

  def self.down
    remove_attachment :users, :image_file_name
  end
end
