class CreateProvas < ActiveRecord::Migration
  def change
    create_table :provas do |t|
      t.references :participantes, index: true, foreign_key: true
      t.references :etapa, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
