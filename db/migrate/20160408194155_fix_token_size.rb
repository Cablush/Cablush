class FixTokenSize < ActiveRecord::Migration
  def change
    change_column :usuario_providers, :token, :string, :limit => 1100
  end
end
