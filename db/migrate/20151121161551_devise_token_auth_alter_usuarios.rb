class DeviseTokenAuthAlterUsuarios < ActiveRecord::Migration

  def self.up
    ## Required
    add_column :usuarios, :provider, :string
    add_column :usuarios, :uid, :string
    ## Tokens
    add_column :usuarios, :tokens, :string
    
    Usuario.reset_column_information
    
    Usuario.all.each do |usuario|
      usuario.provider = "email"
      usuario.uid = usuario.email
      usuario.save!
    end
    
    change_column :usuarios, :provider, :string, :null => false
    change_column :usuarios, :uid, :string, :null => false, :default => ""
  end
  
  def self.down
    remove_column :usuarios, :provider
    remove_column :usuarios, :uid
    remove_column :usuarios, :tokens
  end

end
