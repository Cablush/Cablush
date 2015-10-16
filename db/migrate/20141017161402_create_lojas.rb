class CreateLojas < ActiveRecord::Migration
  def change
    create_table :lojas do |t|
      t.string :nome
      t.text :descricao
      t.string :telefone
      t.string :email
      t.string :website
      t.string :facebook
      
      t.string :logo
      t.boolean :fundo, :default => false
      
      t.references :responsavel, index: true
      
      t.timestamps
    end
  end
end
