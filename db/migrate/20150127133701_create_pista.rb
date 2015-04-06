class CreatePista < ActiveRecord::Migration
  def change
    create_table :pista do |t|
      t.string :nome
      t.text :descricao
      t.string :horario 
      t.string :logo
      t.string :contato
      t.boolean :fundo, :default => false
      t.boolean :facebook

      t.references :local, index: true
      t.references :esporte, index: true
      t.timestamps
    end
  end
end
