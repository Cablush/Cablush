class CreateEtapas < ActiveRecord::Migration
  def change
    create_table :etapas do |t|
      t.string :nome
      t.integer :qtdProvas
      t.integer :numCompetidoresProva

      t.timestamps null: false
    end
  end
end
