class CreateProvasParticipantes < ActiveRecord::Migration
  def change
    create_table :provas_participantes do |t|
      t.decimal :pontuacao

      t.references :participante, index: true
      t.references :prova, index: true

      t.timestamps null: false
    end
  end
end
