class RemoveDeviseTokenAuthFromUsuarios < ActiveRecord::Migration
  def change
    remove_column :usuarios, :provider
    remove_column :usuarios, :uid
    remove_column :usuarios, :tokens
  end
end
