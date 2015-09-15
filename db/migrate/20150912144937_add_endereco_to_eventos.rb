class AddEnderecoToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :endereco, :text
    add_column :eventos, :latitude, :decimal, :precision => 15, :scale => 10, :default => 0.0
    add_column :eventos, :longitude, :decimal, :precision => 15, :scale => 10, :default => 0.0 
  end
end
