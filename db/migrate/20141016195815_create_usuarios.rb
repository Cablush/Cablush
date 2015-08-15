class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.integer :id_social
      t.string :nome
      
      t.references :amigos, index: true
      t.timestamps
    end
  end
end
