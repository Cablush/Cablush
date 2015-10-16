class CreateJoinTablePistaEsporte < ActiveRecord::Migration
  def change
    create_join_table :pistas, :esportes do |t|
      # t.index [:pista_id, :esporte_id]
      # t.index [:esporte_id, :pista_id]
    end
  end
end
