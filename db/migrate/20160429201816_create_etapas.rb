class CreateEtapas < ActiveRecord::Migration
  def change
    create_table :etapas do |t|
      t.string :nome
      t.references :provas, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
