class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome
      t.string :logo
      t.string :descricao
      t.boolean :public, :default => true
      t.boolean :patrocinado, :default => false
      t.time :hora
      t.date :data
      t.string :rota
      t.string :contato
      t.string :facebook
      t.boolean :fundo, :default => false
      
      t.references :local, index: true
      t.references :esporte, index: true
      t.references :participantes, index: true

      t.timestamps
    end
  end
end
