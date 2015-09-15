class AddEstadoAndCidadeToLojas < ActiveRecord::Migration
  def change
    add_reference :lojas, :estado, index: true
    add_foreign_key :lojas, :estados
    
    add_reference :lojas, :cidade, index: true
    add_foreign_key :lojas, :cidades
  end
end
