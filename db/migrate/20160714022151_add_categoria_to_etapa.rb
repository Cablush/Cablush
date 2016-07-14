class AddCategoriaToEtapa < ActiveRecord::Migration
  def change
  	add_reference :etapas, :categoria, index: true, foreign_key: true
  end
end
