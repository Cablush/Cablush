class CreateJoinTableGrupoUsuario < ActiveRecord::Migration
  def change
    create_join_table :grupos, :usuarios do |t|
      # t.index [:grupo_id, :usuario_id]
      # t.index [:usuario_id, :grupo_id]
    end
  end
end
