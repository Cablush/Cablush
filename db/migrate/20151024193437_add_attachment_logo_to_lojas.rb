class AddAttachmentLogoToLojas < ActiveRecord::Migration
  def self.up
    change_table :lojas do |t|
      t.attachment :logo
      t.boolean :fundo, :default => false
    end
  end

  def self.down
    remove_attachment :lojas, :logo
  end
end
