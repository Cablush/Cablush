class AddAttachmentLogoToPistas < ActiveRecord::Migration
  def self.up
    change_table :pistas do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :pistas, :logo
  end
end
