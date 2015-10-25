class AddUuidToUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :uuid, :string
    
    Usuario.reset_column_information
    
    Usuario.all.each do |usuario|
      usuario.uuid = SecureRandom.uuid
      usuario.save!
    end
    
    change_column :usuarios, :uuid, :string, :null => false
    add_index :usuarios, :uuid, unique: true
  end
  
  def self.down
    remove_column :usuarios, :uuid
  end
end
