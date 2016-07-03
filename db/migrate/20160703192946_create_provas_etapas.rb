class CreateProvasEtapas < ActiveRecord::Migration
  def change
    create_table :provas_etapas do |t|
      t.string :prova
      t.string :references
      t.string :etapa
      t.string :references
      t.string :pontuacao
      t.string :decimal

      t.timestamps null: false
    end
  end
end
