class CreateAmizades < ActiveRecord::Migration
  def change
    create_table :amizades do |t|
      t.references :usuario, index: true
      t.references :amigo, index: true
      t.boolean :aprovado

      t.timestamps
    end
  end
end
