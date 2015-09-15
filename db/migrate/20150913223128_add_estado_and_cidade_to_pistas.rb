class AddEstadoAndCidadeToPistas < ActiveRecord::Migration
  def change
    add_reference :pistas, :estado, index: true
    add_foreign_key :pistas, :estados
    
    add_reference :pistas, :cidade, index: true
    add_foreign_key :pistas, :cidades
  end
end
