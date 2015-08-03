class AddRoleToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :role, :integer
  end
end
