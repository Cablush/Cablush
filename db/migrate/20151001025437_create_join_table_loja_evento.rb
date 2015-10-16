class CreateJoinTableLojaEvento < ActiveRecord::Migration
  def change
    create_join_table :lojas, :eventos do |t|
      # t.index [:loja_id, :evento_id]
      # t.index [:evento_id, :loja_id]
    end
  end
end
