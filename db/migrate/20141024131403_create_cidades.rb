class CreateCidades < ActiveRecord::Migration
  def change
    create_table :cidades do |t|
      t.string :nome
      t.references :estado, index: true

      t.timestamps
    end
  end
end
