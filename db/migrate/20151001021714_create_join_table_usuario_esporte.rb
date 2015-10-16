class CreateJoinTableUsuarioEsporte < ActiveRecord::Migration
  def change
    create_join_table :usuarios, :esportes do |t|
      # t.index [:usuario_id, :esporte_id]
      # t.index [:esporte_id, :usuario_id]
    end
  end
end
