class AddAuthenticationTokenToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :authentication_token, :string
    add_index :usuarios, :authentication_token
  end
end
