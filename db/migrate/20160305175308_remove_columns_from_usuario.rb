class RemoveColumnsFromUsuario < ActiveRecord::Migration
  def change
    remove_column :usuarios, :id_social, :string
  end
end
