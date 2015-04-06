class CreateModalidades < ActiveRecord::Migration
  def change
    create_table :modalidades do |t|
      t.string :nome
      t.references :esporte, index: true
      t.string :icon

      t.timestamps
    end
  end
end
