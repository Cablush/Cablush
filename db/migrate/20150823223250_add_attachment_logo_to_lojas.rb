class AddAttachmentLogoToLojas < ActiveRecord::Migration
  def self.up
    change_table :lojas do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :lojas, :logo
  end
end
