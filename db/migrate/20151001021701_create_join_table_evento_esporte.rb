class CreateJoinTableEventoEsporte < ActiveRecord::Migration
  def change
    create_join_table :eventos, :esportes do |t|
      # t.index [:evento_id, :esporte_id]
      # t.index [:esporte_id, :evento_id]
    end
  end
end
