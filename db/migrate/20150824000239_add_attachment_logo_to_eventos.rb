class AddAttachmentLogoToEventos < ActiveRecord::Migration
  def self.up
    change_table :eventos do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :eventos, :logo
  end
end
