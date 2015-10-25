class AddAttachmentFlyerToEventos < ActiveRecord::Migration
  def self.up
    change_table :eventos do |t|
      t.attachment :flyer
      t.boolean :fundo, :default => false
    end
  end

  def self.down
    remove_attachment :eventos, :flyer
  end
end
