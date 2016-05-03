class AddCampeonatoToEtapa < ActiveRecord::Migration
  def change
    add_reference :etapas, :campeonato, index: true, foreign_key: true
  end
end
