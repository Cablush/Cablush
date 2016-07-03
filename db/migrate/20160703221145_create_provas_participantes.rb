class CreateProvasParticipantes < ActiveRecord::Migration
  def change
    create_table :provas_participantes do |t|
      t.decimal :pontuacao

      t.references :participante_id, index: true
      t.references :prova_id, index: true

      t.timestamps null: false
    end
  end
end
