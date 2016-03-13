class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.column :iso, "char(2)"
      t.string :name
      
      t.timestamps null: false
    end
  end
end
