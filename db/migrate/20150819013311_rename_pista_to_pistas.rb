class RenamePistaToPistas < ActiveRecord::Migration
  def change
    rename_table :pista, :pistas
  end
end
