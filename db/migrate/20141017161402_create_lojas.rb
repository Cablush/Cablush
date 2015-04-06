class CreateLojas < ActiveRecord::Migration
  def change
    create_table :lojas do |t|
      t.string :nome
      t.string :logo
      t.time :horario
      t.text :descricao
      t.string :site
      t.string :contato
      t.string :email
      t.string :facebook
      t.boolean :fundo, :default => false
      t.boolean :patrocinado, :default => false
      t.boolean :virtual, :default => false
      
      t.references :local, index: true
      t.references :esporte, index: true
      t.timestamps
    end
  end
end
