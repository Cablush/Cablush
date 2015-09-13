class AddEnderecoToLojas < ActiveRecord::Migration
  def change
    add_column :lojas, :endereco, :text
    add_column :lojas, :latitude, :decimal, :precision => 15, :scale => 10, :default => 0.0
    add_column :lojas, :longitude, :decimal, :precision => 15, :scale => 10, :default => 0.0 
  end
end
