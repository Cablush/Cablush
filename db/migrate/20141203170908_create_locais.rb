class CreateLocais < ActiveRecord::Migration
  def change
    create_table :locais do |t|
      t.decimal :latitude, :precision => 15, :scale => 10, :default => 0.0
      t.decimal :longitude, :precision => 15, :scale => 10, :default => 0.0
      
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.string :cep
      t.string :pais
      
      t.references :localizavel, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
