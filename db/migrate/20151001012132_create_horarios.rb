class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.string :dias
      t.string :periodo
      t.time :inicio
      t.time :fim
      
      t.references :funcionamento, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
