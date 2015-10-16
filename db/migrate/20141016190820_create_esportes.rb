class CreateEsportes < ActiveRecord::Migration
  def change
    create_table :esportes do |t|
      t.string :nome
      t.string :categoria
      t.string :icone
      
      t.timestamps
    end
  end
end
