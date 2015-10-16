class CreatePista < ActiveRecord::Migration
  def change
    create_table :pistas do |t|
      t.string :nome
      t.text :descricao
      
      t.string :foto
      t.boolean :fundo, :default => false
      
      t.references :responsavel, index: true
      
      t.timestamps
    end
  end
end
