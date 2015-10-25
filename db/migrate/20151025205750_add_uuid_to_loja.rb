class AddUuidToLoja < ActiveRecord::Migration
  def self.up
    add_column :lojas, :uuid, :string
    
    Loja.reset_column_information
    
    Loja.all.each do |loja|
      loja.uuid = SecureRandom.uuid
      loja.save!
    end
    
    change_column :lojas, :uuid, :string, :null => false
    add_index :lojas, :uuid, unique: true
  end
  
  def self.down
    remove_column :lojas, :uuid
  end
end
