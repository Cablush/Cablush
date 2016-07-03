class CreateJoinTableCampeonatoEsporte < ActiveRecord::Migration
  def change
    create_join_table :campeonatos, :esportes do |t|
      # t.index [:campeonato_id, :esporte_id]
      # t.index [:esporte_id, :campeonato_id]
    end
  end
end
