class RemoveLogistaFromUsuario < ActiveRecord::Migration
  def change
    remove_column :usuarios, :logista, :boolean
  end
end
