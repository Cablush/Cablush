class CreateJoinTableGrupoEvento < ActiveRecord::Migration
  def change
    create_join_table :grupos, :eventos do |t|
      # t.index [:grupo_id, :evento_id]
      # t.index [:evento_id, :grupo_id]
    end
  end
end
