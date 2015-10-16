class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :nome
      t.string :descricao
      
      t.string :logo
      t.boolean :fundo, :default => false
      
      t.references :responsavel, index: true
      
      t.timestamps
    end
  end
end
