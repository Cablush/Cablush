class AddUuidToEvento < ActiveRecord::Migration
  def self.up
    add_column :eventos, :uuid, :string
    
    Evento.reset_column_information
    
    Evento.all.each do |evento|
      evento.uuid = SecureRandom.uuid
      evento.save!
    end
    
    change_column :eventos, :uuid, :string, :null => false
    add_index :eventos, :uuid, unique: true
  end
  
  def self.down
    remove_column :eventos, :uuid
  end
end
