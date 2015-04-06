class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.column :rg , "char(2)"
      t.string :nome
      t.string :logo

      t.timestamps
    end
  end
end
