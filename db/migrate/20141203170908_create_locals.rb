class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|
      
      t.string :logradouro
      t.decimal  "latitude", :precision => 15, :scale => 10, :default => 0.0
      t.decimal  "longitude", :precision => 15, :scale => 10, :default => 0.0
      
      t.references :cidade, index: true
      t.references :estado, index: true
      t.timestamps
    end
  end
end
