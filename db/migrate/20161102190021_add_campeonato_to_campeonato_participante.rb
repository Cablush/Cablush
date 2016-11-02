class AddCampeonatoToCampeonatoParticipante < ActiveRecord::Migration
  def change
    add_reference :campeonato_participantes, :campeonato
  end
end
