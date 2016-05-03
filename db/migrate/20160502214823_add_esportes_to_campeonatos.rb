class AddEsportesToCampeonatos < ActiveRecord::Migration
  def change
    add_reference :campeonatos, :esportes, index: true, foreign_key: true
  end
end
