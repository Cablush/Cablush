class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome
      t.string :descricao
      t.date :data
      t.time :hora
      t.string :website
      t.string :facebook
      
      t.references :responsavel, index: true

      t.timestamps
    end
  end
end
