class AddAttachmentFotoToPistas < ActiveRecord::Migration
  def self.up
    change_table :pistas do |t|
      t.attachment :foto
      t.boolean :fundo, default: false
    end
  end

  def self.down
    remove_attachment :pistas, :foto
    remove_column :campeonatos, :fundo
  end
end
