class AddUsuarioIdToPista < ActiveRecord::Migration
  def change
  	add_reference :pista, :usuario, index: true
  end
end
