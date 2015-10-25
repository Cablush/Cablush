class CreatePista < ActiveRecord::Migration
  def change
    create_table :pistas do |t|
      t.string :nome
      t.text :descricao
      t.string :website
      t.string :facebook
      
      t.references :responsavel, index: true
      
      t.timestamps
    end
  end
end
