class AddAttachmentFlyerToCampeonatos < ActiveRecord::Migration
  def self.up
    change_table :campeonatos do |t|
      t.attachment :flyer
      t.boolean :fundo, default: false
    end
  end

  def self.down
    remove_attachment :campeonatos, :flyer
  end
end
