class CreateEsportes < ActiveRecord::Migration
  def change
    create_table :esportes do |t|
      t.string :nome
      t.references :modalidade, index: true

      t.timestamps
    end
  end
end
