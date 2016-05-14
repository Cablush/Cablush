class CreateCategoria < ActiveRecord::Migration
  def change
    create_table :categoria do |t|
      t.references :campeonato, index: true, foreign_key: true
      t.string :nome
      t.string :descricao
      t.string :regras

      t.timestamps null: false
    end
  end
end
