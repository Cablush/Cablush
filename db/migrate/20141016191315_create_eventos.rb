class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome
      t.string :descricao
      t.date :data
      t.time :hora
      
      t.string :cartaz
      t.boolean :fundo, :default => false
      
      t.references :responsavel, index: true

      t.timestamps
    end
  end
end
