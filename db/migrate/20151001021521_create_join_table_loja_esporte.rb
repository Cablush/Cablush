class CreateJoinTableLojaEsporte < ActiveRecord::Migration
  def change
    create_join_table :lojas, :esportes do |t|
      # t.index [:loja_id, :esporte_id]
      # t.index [:esporte_id, :loja_id]
    end
  end
end
