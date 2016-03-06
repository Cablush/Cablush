class RemoveColumnsFromUsuario < ActiveRecord::Migration
  def change
    remove_column :usuarios, :id_social, :string
    remove_column :usuarios, :auth_token, :string
  end
end
