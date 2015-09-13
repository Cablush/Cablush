class AddEnderecoToPistas < ActiveRecord::Migration
  def change
	add_column :pistas, :endereco, :text
    add_column :pistas, :latitude, :decimal, :precision => 15, :scale => 10, :default => 0.0
    add_column :pistas, :longitude, :decimal, :precision => 15, :scale => 10, :default => 0.0 
  end
end
