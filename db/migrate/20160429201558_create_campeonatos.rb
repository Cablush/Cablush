class CreateCampeonatos < ActiveRecord::Migration
  def change
    create_table :campeonatos do |t|
      t.string :nome
      t.date :data_inicio
      t.date :data_fim
      t.time :hora
      t.string :descricao
      t.reference :responsavel, index: true

      t.timestamps null: false
    end
  end
end
