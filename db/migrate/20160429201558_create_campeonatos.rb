class CreateCampeonatos < ActiveRecord::Migration
  def change
    create_table :campeonatos do |t|
      t.references :participantes, index: true, foreign_key: true
      t.references :etapas, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
