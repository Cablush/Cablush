class AddEstadoAndCidadeToEventos < ActiveRecord::Migration
  def change
    add_reference :eventos, :estado, index: true
    add_foreign_key :eventos, :estados
    
    add_reference :eventos, :cidade, index: true
    add_foreign_key :eventos, :cidades
  end
end
