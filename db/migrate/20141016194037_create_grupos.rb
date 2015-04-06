class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :nome
      t.string :logo
      t.string :esporte
      t.references :eventos, index: true
      t.references :atletas, index: true

      t.timestamps
    end
  end
end
