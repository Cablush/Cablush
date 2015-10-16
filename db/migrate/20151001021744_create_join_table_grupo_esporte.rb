class CreateJoinTableGrupoEsporte < ActiveRecord::Migration
  def change
    create_join_table :grupos, :esportes do |t|
      # t.index [:grupo_id, :esporte_id]
      # t.index [:esporte_id, :grupo_id]
    end
  end
end
