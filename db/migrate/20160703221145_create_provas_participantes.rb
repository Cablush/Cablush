class CreateProvasParticipantes < ActiveRecord::Migration
  def change
    create_table :provas_participantes do |t|
      t.string :prova
      t.string :references
      t.string :participante
      t.string :references
      t.string :pontuacao
      t.string :decimal

      t.timestamps null: false
    end
  end
end
