class AddUuidToPista < ActiveRecord::Migration
  def self.up
    add_column :pistas, :uuid, :string
    
    Pista.reset_column_information
    
    Pista.all.each do |pista|
      pista.uuid = SecureRandom.uuid
      pista.save!
    end
    
    change_column :pistas, :uuid, :string, :null => false
    add_index :pistas, :uuid, unique: true
  end
  
  def self.down
    remove_column :pistas, :uuid
  end
end
